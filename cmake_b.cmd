SET ES_DEPS=C:/SolvIT/Dev/es-deps
cls
pushd %~dp0
md build
cd build

C:\Solvit\Dev\cmake-3.12.2-win64-x64\bin\cmake ^
 -DFREETYPE_INCLUDE_DIRS=%ES_DEPS%/freetype/include -DFREETYPE_LIBRARY=%ES_DEPS%/freetype/freetype.lib ^
 -DFreeImage_INCLUDE_DIR=%ES_DEPS%/FreeImage/include -DFreeImage_LIBRARY=%ES_DEPS%/FreeImage/FreeImage.lib ^
 -DSDL2_INCLUDE_DIR=%ES_DEPS%/SDL2/include -DSDL2_LIBRARY=%ES_DEPS%/SDL2/lib/x86/SDL2.lib;%ES_DEPS%/SDL2/lib/x86/SDL2main.lib;Imm32.lib;version.lib ^
 -DCURL_INCLUDE_DIR=%ES_DEPS%/curl/include -DCURL_LIBRARY=%ES_DEPS%/curl/lib/libcurl.lib ^
 -DVLC_INCLUDE_DIR="%ES_DEPS%/vlc/include" ^
 -DVLC_LIBRARIES="%ES_DEPS%/vlc/lib/msvc/libvlc.lib;%ES_DEPS%/vlc/lib/msvc/libvlccore.lib"  ^
 -DRAPIDJSON_INCLUDE_DIRS="%ES_DEPS%/rapidjson/include" ^
../
 
popd