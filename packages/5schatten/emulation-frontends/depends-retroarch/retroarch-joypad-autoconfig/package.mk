# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="cea8dc549e122287c1c5c76f15feaf10d8e94d3f"
PKG_SHA256="4630e5f7fd890a5bf6b84130f62b0f0b864555cec3efe86b42e14ca5706d1177"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig.git"
PKG_URL="https://github.com/libretro/retroarch-joypad-autoconfig/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm $PKG_BUILD/configure $PKG_BUILD/Makefile
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/autoconfig
  cp -r * $INSTALL/usr/share/retroarch/autoconfig
}

post_makeinstall_target () {
  cp -r $PKG_DIR/config/* $INSTALL/usr/share/retroarch/autoconfig
}
