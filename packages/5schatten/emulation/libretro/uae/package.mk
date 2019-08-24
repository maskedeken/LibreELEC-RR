# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="uae"
PKG_VERSION="b2af02e9cc4d3258012aa3381a10484e390d5062"
PKG_SHA256="f50c09e7c3c898940a007cf4d9558515f91c1674376b67852712d4d700e73d44"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="Libretro wrapper for UAE emulator."

PKG_LIBNAME="puae_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    CFLAGS+=" -DARM -marm"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
