cmake_minimum_required(VERSION 3.14)
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 1)
project(r_pipeline VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})

include(r_build.txt)
include(FFMPEGConfig.cmake REQUIRED)
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
    ${GST_INCLUDE_DIRS}
)

target_link_directories(
    r_pipeline PUBLIC
    ${GST_LIB_DIRS}
)

target_link_libraries(
    r_pipeline
    r_utils
    ${GST_LIBS}
)

add_subdirectory(ut)