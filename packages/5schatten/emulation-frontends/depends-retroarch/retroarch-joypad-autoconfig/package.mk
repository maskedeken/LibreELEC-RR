# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="012505b5fbaf48947137c7b104d66972ac9a94ac"
PKG_SHA256="0afe3baec775f66b43101c55e37d2833bff5e2e9f8900524b9c94fc60d7774dd"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="https://github.com/libretro/retroarch-joypad-autoconfig/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/autoconfig"
}

post_makeinstall_target () {
  cp -r $PKG_DIR/config/* ${INSTALL}/usr/share/retroarch/autoconfig
}
