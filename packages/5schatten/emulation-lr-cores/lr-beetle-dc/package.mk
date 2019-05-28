# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="lr-beetle-dc"
PKG_VERSION="d9f44d040647ce3b6e66fb9b10e587953318b42f"
PKG_SHA256="25c9497da0cb0c8118ebde28b8916f677133cd8b85cf9f7aa6be4080de4ad0a4"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-dc"
PKG_URL="https://github.com/libretro/beetle-dc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Beetle DC is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="beetle-dc_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="HAVE_OPENMP=0 GIT_VERSION=${PKG_VERSION:0:7} WITH_DYNAREC=${ARCH}"

configure_package() {
  # Apply project specific patches
  PKG_PATCH_DIRS="${PROJECT}"

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
      elif [ "${DEVICE}" = "RK3328" ] || [ "${DEVICE}" = "TinkerBoard" ]; then
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
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/reicast_libretro.so
}
