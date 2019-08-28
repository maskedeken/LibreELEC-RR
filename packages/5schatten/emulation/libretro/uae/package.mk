# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="uae"
PKG_VERSION="0dcc239e445b59309815b2d1f557298a153c45ae"
PKG_SHA256="4d56509b1ee2cf75e8b948a32b11d1944a286bfb7470281d004ee47b7672a702"
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
