# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="prboom"
PKG_VERSION="54188e4591ee1258f313d60ae3a1381828e1891b"
PKG_SHA256="c54a14bce02d7b9457fdd9805ef04168ec37113947c9a029e288e07e9bbc8403"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="https://github.com/libretro/libretro-prboom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Port of prboom to libretro - plays Doom, Doom II, Final Doom and other Doom IWAD mods."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="prboom_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/lib/libretro
  mkdir -p ${INSTALL}/usr/share/prboom

  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/prboom.wad ${INSTALL}/usr/share/prboom
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

