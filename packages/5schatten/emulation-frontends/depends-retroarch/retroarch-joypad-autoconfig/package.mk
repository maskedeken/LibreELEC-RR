# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="01891a83e99c2999a997e9c5724d72bc6ce61e0c"
PKG_SHA256="32a5d9bb5f7857d129abacc80898ed49d84928cd6dd47da5bba7e571356f41db"
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
