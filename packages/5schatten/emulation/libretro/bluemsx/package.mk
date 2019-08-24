# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="bluemsx"
PKG_VERSION="f7795d8936fdbca682a30cd87a86a51e9fb94033"
PKG_SHA256="1386921df6fca116e1df007eff37e83492cf83e4d4d572a808b8f5d8b2c31c85"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/blueMSX-libretro"
PKG_URL="https://github.com/libretro/blueMSX-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Port of blueMSX to the libretro API."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="bluemsx_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
