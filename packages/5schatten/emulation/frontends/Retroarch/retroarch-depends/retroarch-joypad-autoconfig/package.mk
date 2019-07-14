# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="c7cb3fbe4fb6a94b1613eee494591f9d51652a2b"
PKG_SHA256="a3872c53966f676025f30bf24fe606577140581928a82a9f5f0fe87aecd20d88"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="https://github.com/libretro/retroarch-joypad-autoconfig/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/autoconfig"
}
