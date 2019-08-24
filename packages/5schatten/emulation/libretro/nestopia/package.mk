# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="nestopia"
PKG_VERSION="0806f9194735f4af28d3f4fe6165212f5e142a58"
PKG_SHA256="111b6a8f8831edc04c2ed34f5ac8f399ea79cc3f102f5bbaee1ad47f144be904"
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
    fi
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
