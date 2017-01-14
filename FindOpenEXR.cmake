set(OPENEXR_INCLUDE_DIRS ${CONAN_INCLUDE_DIRS_OPENEXR};${CONAN_INCLUDE_DIRS_ILMBASE})
set(OPENEXR_LIBRARY_DIRS ${CONAN_LIB_DIRS_OPENEXR};${CONAN_LIB_DIRS_ILMBASE})
set(OPENEXR_LIBRARIES    ${CONAN_LIBS_OPENEXR};${CONAN_LIBS_ILMBASE})

set(OPENEXR_INCLUDE_DIR  ${OPENEXR_INCLUDE_DIRS})
set(OPENEXR_LIBRARY_DIR  ${OPENEXR_LIBRARY_DIRS})
set(OPENEXR_LIBRARY      ${OPENEXR_LIBRARIES})

foreach (LIBNAME ${OPENEXR_LIBRARIES})
    string(REGEX MATCH "[^-]+" LIBNAME_STEM ${LIBNAME})
    set(OPENEXR_${LIBNAME_STEM}_LIBRARY ${LIBNAME})
endforeach()

foreach (INCLUDE_DIR ${OPENEXR_INCLUDE_DIRS})
    if(NOT OPENEXR_VERSION AND INCLUDE_DIR AND EXISTS "${INCLUDE_DIR}/OpenEXR/OpenEXRConfig.h")
      file(STRINGS
           ${INCLUDE_DIR}/OpenEXR/OpenEXRConfig.h
           TMP
           REGEX "#define OPENEXR_VERSION_STRING.*$")
      string(REGEX MATCHALL "[0-9.]+" OPENEXR_VERSION ${TMP})
    endif()
endforeach()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenEXR
    REQUIRED_VARS
        OPENEXR_INCLUDE_DIRS
        OPENEXR_LIBRARY_DIRS
        OPENEXR_LIBRARIES
    VERSION_VAR
        OPENEXR_VERSION
)
