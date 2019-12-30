# Try to find OpenGLES2. Once done this will define:
#     OPENGLES2_FOUND
#     OPENGLES2_INCLUDE_DIRS
#     OPENGLES2_LIBRARIES
#     OPENGLES2_DEFINITIONS

find_package(PkgConfig)

# Use the BRCM GL driver by default, unless overridden by the USE_MESA_GLES flag
if(BCMHOST AND NOT(USE_MESA_GLES))
  pkg_check_modules(PC_OPENGLES2 brcmglesv2)
  set(OPENGLES2_NAMES brcmGLESv2)
else()
  set(OPENGLES2_NAMES glesv2 GLESv2)
  pkg_check_modules(PC_OPENGLES2 glesv2)
endif()

if (PC_OPENGLES2_FOUND)
    set(OPENGLES2_DEFINITIONS ${PC_OPENGLES2_CFLAGS_OTHER})
endif ()

find_path(OPENGLES2_INCLUDE_DIRS NAMES GLES2/gl2.h
    HINTS ${PC_OPENGLES2_INCLUDEDIR} ${PC_OPENGLES2_INCLUDE_DIRS}
)

set(OPENGLES2_NAMES ${OPENGLES2_NAMES})
find_library(OPENGLES2_LIBRARIES NAMES ${OPENGLES2_NAMES}
    HINTS ${PC_OPENGLES2_LIBDIR} ${PC_OPENGLES2_LIBRARY_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenGLES2 REQUIRED_VARS OPENGLES2_INCLUDE_DIRS OPENGLES2_LIBRARIES
                                  FOUND_VAR OPENGLES2_FOUND)

mark_as_advanced(OPENGLES2_INCLUDE_DIRS OPENGLES2_LIBRARIES)
