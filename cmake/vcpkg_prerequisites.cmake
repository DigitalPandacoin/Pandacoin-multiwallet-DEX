message(STATUS "VCPKG package manager enabled")
string(TOLOWER $ENV{CMAKE_BUILD_TYPE} VCPKG_BUILD_TYPE)
message(STATUS "using VCPKG_BUILD_TYPE ${VCPKG_BUILD_TYPE}"
set(VCPKG_BUILD_TYPE ${VCPKG_BUILD_TYPE})
set(VCPKG_OVERLAY_TRIPLETS "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set(VCPKG_OVERLAY_PORTS "${CMAKE_CURRENT_SOURCE_DIR}/ci_tools_atomic_dex/vcpkg-custom-ports/ports" CACHE STRING "")
set(_VCPKG_INSTALLED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/ci_tools_atomic_dex/vcpkg-repo/installed")
set(CMAKE_TOOLCHAIN_FILE
        "${CMAKE_CURRENT_SOURCE_DIR}/ci_tools_atomic_dex/vcpkg-repo/scripts/buildsystems/vcpkg.cmake"
        CACHE STRING "")

if (WIN32)
    set(VCPKG_TARGET_TRIPLET "x64-windows-custom")
endif ()

if (APPLE)
    set(VCPKG_APPLOCAL_DEPS OFF CACHE BOOL "")
endif ()
