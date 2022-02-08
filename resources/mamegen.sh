#!/usr/bin/env bash
#
# Script that generates the MAME resoursce files used by EmulationStation:
# 1. Mame BIOS file in mamebioses.xml
# 2. Mame Device file in mamedevice.xml
# 3. Mame arcade games name failes in mamenames.xml
#
# It needs 'curl' and 'xmlstarlet' to run and downloads the MAME Dat files https://from progettosnaps.net
#
# Usage: script [<version>]
#   where <version> is the Mame version

set -eE

# MAME version
VER=240
[[ -n "$1" ]] && VER="$1"

echo "Creating resources for MAME $VER"

_tmp="$(mktemp -d)"
[[ -d "${_tmp}" ]] || {
    echo "Temporary folder not found !"
    exit 1
}
# Make sure we cleanup on exit
trap "rm -fr ${_tmp}" EXIT ERR SIGINT

pushd "$_tmp"
curl -f -o "${VER}_dat.7z" --location "https://www.progettosnaps.net/download/?tipo=dat_mame&file=/dats/MAME/packs/MAME_Dats_${VER}.7z"

# Extract the files from the DAT archive
7z e "${VER}_dat.7z" -o"$_tmp" \
    "DATs/BIOSes/MAME_BIOS_${VER}.dat" \
    "DATs/DEVICEs/MAME_Devices_${VER}.dat" \
    "DATs/ARCADE 0.${VER}.dat" 2>/dev/null

popd
# Process BIOS files
xmlstarlet sel -net -D -T -B -E utf-8  -t -m '//machine' -v 'concat("<bios>",@name,"</bios>")' -n "${_tmp}/MAME_BIOS_${VER}.dat" > mamebioses.xml 2>/dev/null

# Process Device files
xmlstarlet sel -net -D -T -B -E utf-8  -t -m '//machine' -v 'concat("<device>",@name,"</device>")' -n "${_tmp}/MAME_Devices_${VER}.dat" > mamedevices.xml 2>/dev/null


# create a XLST transform specification to extract game data for Arcade games
cat << EOF > "${_tmp}/p$$.xsl"
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="yes" />
<xsl:template match="/">
<xsl:for-each select="//machine[not(@isdevice) and not(@isbios)]">
     <xsl:value-of select="@name"/>
     <xsl:text>;</xsl:text>
     <xsl:value-of select="description" disable-output-escaping="no" />
     <xsl:text>&#10;</xsl:text>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
EOF
# Process Arcade Roms
xmlstarlet tr "${_tmp}/p$$.xsl" "${_tmp}/ARCADE 0.${VER}.dat" | sed -En 's#([^;]+);(.*)#<game>\n\t<mamename>\1</mamename>\n\t<realname>\2</realname>\n</game>#p' > mamenames.xml

echo Resource files succesfully built
exit 0
