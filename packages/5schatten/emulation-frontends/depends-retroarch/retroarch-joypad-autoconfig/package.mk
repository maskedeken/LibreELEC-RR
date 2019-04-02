# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="b6e0311b33d484d918696c059725112dc2a83555"
PKG_SHA256="7784f4aa1b0c7438b7c92cac0e9f96cfdcbfc894ba90c2d1e0946eacb93f279c"
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
