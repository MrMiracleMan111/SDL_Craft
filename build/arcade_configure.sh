#!/bin/sh

LINARO_BIN=~/Desktop/ArcadeDeviceProjects/CompilerTools/gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf/bin/
LIB32=~/Desktop/ArcadeDeviceProjects/CompilerTools/lib
USR_LIB=~/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib
DIR=~/Desktop/ArcadeDeviceProjects/CompilerTools/gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf/bin
INCLUDE=~/Desktop/ArcadeDeviceProjects/CompilerTools/include
ALSA_LIB=~/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib/alsa-lib

GLIB_INCLUDE=/usr/include/glib-2.0

export GLIB_INCLUDE_DIRS=$GLIB_INCLUDE

# Exports
export ARCH=arm
export CROSS_COMPILE=aarm-linux-gnueabihf-
export NM=$DIR/arm-linux-gnueabihf-nm
export LD=$DIR/arm-linux-gnueabihf-ld
export RANLIB=$DIR/arm-linux-gnueabihf-ranlib
export AR=$DIR/arm-linux-gnueabihf-ar

export PKG_CONFIG_PATH="~/Desktop/ArcadeDeviceProjects/CompilerTools/pkg-config"
export PKG_CONFIG_LIBDIR="~/Desktop/ArcadeDeviceProjects/CompilerTools/lib;~/Desktop/ArcadeDeviceProjects/CompilerTools/usr/lib;"
# export LIBGBM_LIBS="-L$USR_LIB -ldrm"
# export LIBDRM_LIBS="-L$USR_LIB -lgbm"

# Compiler
export CXX=$DIR/arm-linux-gnueabihf-g++
export CC=$DIR/arm-linux-gnueabihf-gcc

export C_FLAGS="-rdynamic -funwind-tables -I$GLIB_INCLUDE"
export CXX_FLAGS="-rdynamic -funwind-tables -I$GLIB_INCLUDE"

INSTALL_DIR=~/Desktop/ArcadeDeviceProjects/projects/SDL_Craft/install


export LDFLAGS="-L$LIB32 -L$USR_LIB -L$ALSA_LIB"
export LDLIBS="-lcurl-d -lpthread-2.6 -ldrm -lxkbcommon -lpixman-1 -lffi -lwayland-client -lwayland-server -lgbm -lmali-utgard-400-r7p0-r1p1-wayland"
export LINKER_FLAGS="$LDFLAGS $LDLIBS"
CONFIG_ARGS="\
"


COMPILE_ARGS="\
-DCMAKE_CXX_COMPILER=$DIR/arm-linux-gnueabihf-g++ \
-DCMAKE_C_COMPILER=$DIR/arm-linux-gnueabihf-gcc \
-DCMAKE_C_FLAGS=$C_FLAGS \
-DCMAKE_CXX_FLAGS=$CXX_FLAGS \
-DALSA_LIBRARY=$ALSA_LIB \
-DOPENGL_opengl_LIBRARY=$USR_LIB \
-DOPENGL_glx_LIBRARY=$USR_LIB \
-DEGL_LIBRARY=$USR_LIB \
-DCMAKE_MODULE_LINKER_FLAGS=-L$USR_LIB -L$LIB32 $LDLIBS \
-DCMAKE_EXE_LINKER_FLAGS=-L$USR_LIB -L$LIB32 $LDLIBS \
-DCMAKE_SHARED_LINKER_FLAGS=-L$USR_LIB -L$LIB32 $LDLIBS \
-DCMAKE_STATIC_LINKER_FLAGS=-L$USR_LIB -L$LIB32 $LDLIBS \
-DCURL_LIBRARIES=curl-d \
-DCURL_INCLUDE_DIR=$INCLUDE \
-DCURL_LIBRARY=curl-d \
-DGLFW_USE_WAYLAND=1 \
"

#cmake -U
#rm CMakeCache.txt
cmake -DCMAKE_BUILD_TYPE=DEBUG $CONFIG_ARGS $COMPILE_ARGS -lpthread ..
cmake --build . --config Debug --parallel
