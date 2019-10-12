# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="kronos"
PKG_VERSION="595cd20e2a7f550fe5597a8ef4999026ad2e3818"
PKG_SHA256="3c065e7182704427da5a3adbcbdee5a0f4b3fa433466003d7613364b7d8d17f6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Kronos is a Sega Saturn emulator forked from uoYabause. "
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="kronos_libretro.so"
PKG_LIBPATH="yabause/src/libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro GIT_VERSION=${PKG_VERSION:0:7}"

configure_package() {
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
    PKG_PATCH_DIRS="OpenGLES"
  fi
}

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    if [ "${DEVICE}" = "RK3399" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=rockpro64"
    elif [ "${DEVICE}" = "AMLG12" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=amlg12"
    else
      PKG_MAKE_OPTS_TARGET+=" platform=armv"
      # ARM NEON support
      if target_has_feature neon; then
        PKG_MAKE_OPTS_TARGET+="-neon"
      fi
      PKG_MAKE_OPTS_TARGET+="-${TARGET_FLOAT}float-${TARGET_CPU}"
    fi
  fi
}

pre_make_target() {
  make CC=${HOST_CC} -C yabause/src/libretro generate-files
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
