cmake_minimum_required(VERSION 3.14)
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 1)
project(r_pipeline VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})

include(r_build.txt)
include(FetchContent)

FetchContent_Declare(
    r_utils
    GIT_REPOSITORY https://github.com/dicroce/r_utils.git
    GIT_TAG        main
)
FetchContent_MakeAvailable(r_utils)

FetchContent_Declare(
    r_fakey
    GIT_REPOSITORY https://github.com/dicroce/r_fakey.git
    GIT_TAG        main
)
FetchContent_MakeAvailable(r_fakey)

find_package(PkgConfig)
pkg_search_module(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0)
pkg_search_module(gstreamer-sdp REQUIRED IMPORTED_TARGET gstreamer-sdp-1.0)
pkg_search_module(gstreamer-app REQUIRED IMPORTED_TARGET gstreamer-app-1.0)
pkg_search_module(gstreamer-video REQUIRED IMPORTED_TARGET gstreamer-video-1.0)
pkg_search_module(gstreamer-rtsp-server REQUIRED IMPORTED_TARGET gstreamer-rtsp-server-1.0)
pkg_search_module(gstreamer-codecparsers REQUIRED IMPORTED_TARGET gstreamer-codecparsers-1.0)
pkg_search_module(gstreamer-plugins-base REQUIRED IMPORTED_TARGET gstreamer-plugins-base-1.0)
pkg_search_module(gstreamer-plugins-good REQUIRED IMPORTED_TARGET gstreamer-plugins-good-1.0)
pkg_search_module(gstreamer-plugins-bad REQUIRED IMPORTED_TARGET gstreamer-plugins-bad-1.0)


add_library(
    r_pipeline
    include/r_pipeline/r_arg.h
    source/r_arg.cpp
    include/r_pipeline/r_gst_source.h
    source/r_gst_source.cpp
    include/r_pipeline/r_stream_info.h
    source/r_stream_info.cpp
    include/r_pipeline/r_sample_context.h
    source/r_sample_context.cpp
    include/r_pipeline/r_gst_buffer.h
    source/r_gst_buffer.cpp
)

target_include_directories(
    r_pipeline PUBLIC
    include
    ${r_utils_SOURCE_DIR}/include
    ${r_fakey_SOURCE_DIR}/include

    PkgConfig::gstreamer
    PkgConfig::gstreamer-sdp
    PkgConfig::gstreamer-app
    PkgConfig::gstreamer-video
)

target_compile_options(
    r_pipeline PUBLIC
    #PkgConfig::gstreamer
    #PkgConfig::gstreamer-sdp
    #PkgConfig::gstreamer-app
    #PkgConfig::gstreamer-video
    #    ${GST_CFLAGS}
)

target_link_directories(
    r_pipeline PUBLIC
    PkgConfig::gstreamer
    PkgConfig::gstreamer-sdp
    PkgConfig::gstreamer-app
    PkgConfig::gstreamer-video
)

target_link_libraries(
    r_pipeline
    r_utils
    PkgConfig::gstreamer
    PkgConfig::gstreamer-sdp
    PkgConfig::gstreamer-app
    PkgConfig::gstreamer-video
)

add_subdirectory(ut)