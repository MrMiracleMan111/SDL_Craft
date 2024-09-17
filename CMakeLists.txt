cmake_minimum_required(VERSION 2.8)

project(craft)

FILE(GLOB SOURCE_FILES src/*.c)

if (ARM_ARCADE)
    add_definitions(-DUSE_KMSDRM)
    list(APPEND CMAKE_PREFIX_PATH "/home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib")
    list(APPEND CMAKE_PREFIX_PATH "/home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/lib")
    set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "/home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib")
    set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "/home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/lib")
    set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -pthread")
    set(SDL_PATH /home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib/libSDL2.so)
    link_directories("/home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib")
    link_directories("/home/jack/Desktop/ArcadeDeviceProjects/CompilerTools/usr")
endif()

add_executable(
    craft
    ${SOURCE_FILES}
    deps/lodepng/lodepng.c
    deps/noise/noise.c
    deps/sqlite/sqlite3.c
    deps/tinycthread/tinycthread.c)

add_definitions(-std=c99 -O3)
include_directories(~/Desktop/ArcadeDeviceProjects/CompilerTools/include)
include_directories(deps/lodepng)
include_directories(deps/noise)
include_directories(deps/sqlite)
include_directories(deps/tinycthread)

if (ARM_ARCADE)
    target_link_libraries(craft PUBLIC ${SDL2_LIBRARY})
endif()

if(MINGW)
    set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH}
        "C:/Program Files/CURL/lib" "C:/Program Files (x86)/CURL/lib")
    set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH}
        "C:/Program Files/CURL/include" "C:/Program Files (x86)/CURL/include")
endif()

if (ARM_ARCADE)
    find_package(CURL REQUIRED)
    include_directories(${CURL_INCLUDE_DIR})
endif()

if(APPLE)
    target_link_libraries(craft dl pthread GLESv2 SDL2 m
${CURL_LIBRARIES})
endif()

if(UNIX)
    if (ARM_ARCADE)
        target_link_libraries(craft dl pthread drm xkbcommon pixman-1 ffi wayland-client wayland-server gbm mali-utgard-400-r7p0-r1p1-wayland GLESv2 SDL2 m curl-d)
    else()
        target_link_libraries(craft dl pthread SDL2 GL m -lcurl)
    endif()
endif()

if(MINGW)
    target_link_libraries(craft ws2_32.lib dl pthread GLESv2 SDL2 m
       ${CURL_LIBRARIES})
endif()
