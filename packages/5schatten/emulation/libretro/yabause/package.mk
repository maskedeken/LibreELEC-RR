# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="yabause"
PKG_VERSION="d28d74d928a80371761a8d44ef9c95d08ed5992e"
PKG_SHA256="46c9fa02cfacd59b9cc3ab700eb8b9c1860c3f3d1e081d3d358d70fd33b1008a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Yabause is a Sega Saturn emulator."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="yabause_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C libretro GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
