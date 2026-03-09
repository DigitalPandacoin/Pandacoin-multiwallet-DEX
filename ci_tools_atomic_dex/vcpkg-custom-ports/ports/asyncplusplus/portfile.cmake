vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cipig/asyncplusplus
    HEAD_REF master
    REF 5fc8fd8dcf4f008e21aba8ecfb02c34d3eb57638
    SHA512 f0d5d746ff8b0e76a6b143420347883f000f4741d536096548df829a33641cbdbea0fb37bf238314350653e6207cf53ee32826863b19d940bae5380415a22db9
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH cmake PACKAGE_NAME async++)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
