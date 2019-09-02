# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="nestopia"
PKG_VERSION="e56a04ae23d928bb50b213642e4729608f69efb8"
PKG_SHA256="668b765ee2697f43acfbc058ec48ea30aa9a4a3ddf7dc66377a0ae1402b8d0ac"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/nestopia"
PKG_URL="https://github.com/libretro/nestopia/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="This project is a fork of the original Nestopia source code, plus the Linux port"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="nestopia_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C libretro GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    if [ "${PROJECT}" = "RPi" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
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

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
