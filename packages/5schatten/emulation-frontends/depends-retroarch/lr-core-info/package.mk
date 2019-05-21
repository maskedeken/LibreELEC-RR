# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="lr-core-info"
PKG_VERSION="cd22a6ae55e07a4a8898f4a2ccb17b27e9e2626e" # v1.7.7+
PKG_SHA256="34bc5e3409a8b12c8dcfc4b7728cf696eff22503f604041ecf7e89a647b109d9"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="https://github.com/libretro/libretro-core-info/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro's core info files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/coreinfo"
}
