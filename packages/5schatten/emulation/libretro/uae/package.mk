# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="uae"
PKG_VERSION="4f66df9f129622602b56c7b2fba6dbd726db365d"
PKG_SHA256="8a85aaad9d11fdd7c5bbb0f421564fbfd65d2b6d8d88cfb53d6d7efb17b770a3"
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
