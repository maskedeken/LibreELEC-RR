# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="flycast-lr"
PKG_VERSION="b2ef4b8b266b04141509d8c15a453d0ae9a704ba"
PKG_SHA256="b8469f76add9caf718b9c440a606be9ac38246d16664cbdc07b80d9976f0ed48"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="https://github.com/libretro/flycast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="flycast_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="HAVE_OPENMP=0 GIT_VERSION=${PKG_VERSION:0:7} WITH_DYNAREC=${ARCH}"

configure_package() {
  # Apply project specific patches
  if [ "${OPENGLES}" = "libmali" ]; then
    PKG_PATCH_DIRS="libmali"
  fi

  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

pre_configure_target() {
  case ${PROJECT} in
    Amlogic)
      if [ "${DEVICE}" = "AMLG12" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=odroid-n2"
      else
        PKG_MAKE_OPTS_TARGET+=" platform=armv-gles-neon"
      fi
      ;;
    Generic)
      PKG_MAKE_OPTS_TARGET+=" HAVE_OIT=1"
      ;;
    RPi)
      if [ "${DEVICE}" = "RPi2" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
      else
        PKG_MAKE_OPTS_TARGET+=" platform=rpi"
      fi
      ;;
    Rockchip)
      if [ "${DEVICE}" = "RK3399" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=rockpro64"
      else
        PKG_MAKE_OPTS_TARGET+=" platform=tinkerboard"
      fi
      ;;
    *)
      if [ "${ARCH}" = "arm" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        # OpenGL ES support
        if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
          PKG_MAKE_OPTS_TARGET+="-gles"
        fi
        # ARM NEON support
        if target_has_feature neon; then
          PKG_MAKE_OPTS_TARGET+="-neon"
        fi
      fi
      ;;
  esac
 # LDFLAGS+=" -lrt"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
