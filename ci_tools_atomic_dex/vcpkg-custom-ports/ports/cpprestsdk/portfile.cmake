vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cipig/cpprestsdk
    HEAD_REF master
    REF 74df27c8edf3f7b7fdfd3d6aacbdef6bb0057dd7
    SHA512 43f00c0dea27c6b4e7444dcc5312c5c6a8f5f897a4b1d56289e410d327e32c217ea4f8a8e4e5a07bf7cf26e156615b1f21d0879ea0b752d200f9486a89804929
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    INVERTED_FEATURES
      brotli CPPREST_EXCLUDE_BROTLI
      compression CPPREST_EXCLUDE_COMPRESSION
      websockets CPPREST_EXCLUDE_WEBSOCKETS
)

if(VCPKG_TARGET_IS_UWP)
    set(configure_opts WINDOWS_USE_MSBUILD)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/Release"
    ${configure_opts}
    OPTIONS
        ${FEATURE_OPTIONS}
        -DBUILD_TESTS=OFF
        -DBUILD_SAMPLES=OFF
        -DCPPREST_EXPORT_DIR=share/cpprestsdk
        -DWERROR=OFF
        -DPKG_CONFIG_EXECUTABLE=FALSE
    OPTIONS_DEBUG
        -DCPPREST_INSTALL_HEADERS=OFF
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH "lib/share/${PORT}")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/share" "${CURRENT_PACKAGES_DIR}/lib/share")

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/cpprest/details/cpprest_compat.h"
        "#ifdef _NO_ASYNCRTIMP" "#if 1")
endif()

file(INSTALL "${SOURCE_PATH}/license.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
