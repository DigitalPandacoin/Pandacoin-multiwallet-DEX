vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cipig/cpprestsdk
    HEAD_REF master
    REF 58cb96bf6493a9435b14c18ccd0b270367f58718
    SHA512 5bb4113836b9b2d8d328406a2e735c534515c85a3b2b2ca359f7008c923e4e355328754f7df15ae238484d426a80e3539cdf696daa1b1498835da6758c0bdddb
    SHA512 60798aaacb5ff5453f95a64cfe222af31e7b8161821fdb2937ec0c222f1b2f94f56c62e94993e28d5ec3872db337d11d1e22b2018eef304c9283b3937ba827b7
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
#        -DCPPREST_EXCLUDE_WEBSOCKETS=ON
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
