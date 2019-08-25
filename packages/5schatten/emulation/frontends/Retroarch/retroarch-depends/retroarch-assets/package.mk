# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="retroarch-assets"
PKG_VERSION="ffffb2cf4dc5586de41e4e2ae2ca7533c472178e"
PKG_SHA256="0664ec00270363beee274c46bf0a92e2f607756b87aef9cfc5b8f8b973eeb535"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="https://github.com/libretro/retroarch-assets/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/assets"
}
