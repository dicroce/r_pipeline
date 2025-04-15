include(FFMPEGConfig.cmake REQUIRED)

FetchContent_Declare(
    r_av
    GIT_REPOSITORY https://github.com/dicroce/r_av.git
    GIT_TAG        main
    FIND_PACKAGE_ARGS NAMES r_av
)
FetchContent_MakeAvailable(r_av)

add_executable(
    r_pipeline_ut
    include/framework.h
    source/framework.cpp
    include/utils.h
    source/utils.cpp
    include/test_r_pipeline.h
    source/test_r_pipeline.cpp
)

if(MSVC)
    target_link_options(r_pipeline_ut PUBLIC "/STACK:10000000")
endif()

target_include_directories(
    r_pipeline_ut PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(
    r_pipeline_ut LINK_PUBLIC 
    r_fakey
    r_pipeline
    r_av
    r_utils
    ${GST_LIBS}
    ${FFMPEG_LIBS}
    bz2
)
