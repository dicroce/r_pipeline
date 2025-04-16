if(NOT TARGET gstreamer)

    if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        add_library(gstreamer INTERFACE IMPORTED GLOBAL)
        set_target_properties(gstreamer PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "$ENV{GST_TOP_DIR}/include/gstreamer-1.0;$ENV{GST_TOP_DIR}/include/glib-2.0;$ENV{GST_TOP_DIR}/lib/glib-2.0/include"
            INTERFACE_LINK_DIRECTORIES "$ENV{GST_TOP_DIR}/lib"
            INTERFACE_LINK_LIBRARIES
                "gstreamer-1.0.lib;gstapp-1.0.lib;gstsdp-1.0.lib;gstrtp-1.0.lib;gstrtspserver-1.0.lib;gstcodecparsers-1.0.lib;gobject-2.0.lib;gmodule-2.0.lib;xml2.lib;gthread-2.0.lib;glib-2.0.lib"
        )

        set(GST_LIBS gstreamer)
    endif()

    if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
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

        add_library(gstreamer INTERFACE IMPORTED GLOBAL)
        set_target_properties(gstreamer PROPERTIES
            INTERFACE_LINK_LIBRARIES
                "PkgConfig::gstreamer;PkgConfig::gstreamer-sdp;PkgConfig::gstreamer-app;PkgConfig::gstreamer-video;PkgConfig::gstreamer-codecparsers;PkgConfig::gstreamer-rtsp-server"
        )

        set(GST_LIBS gstreamer)
    endif()

endif()
