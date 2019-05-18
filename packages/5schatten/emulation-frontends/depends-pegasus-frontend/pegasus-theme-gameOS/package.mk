# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="pegasus-theme-gameOS"
PKG_VERSION="73026a26e15d234d5ecf93def6931a7c17399e3d" # v0.5+
PKG_SHA256="f69ff39cda66a9e37ffa7965b617662e76ea1e75a285dcc4994ba7620249d42b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/PlayingKarrde/gameOS"
PKG_URL="https://github.com/PlayingKarrde/gameOS/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="gameOS theme for Pegasus Frontend"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/pegasus-frontend/themes/gameOS
  cp -a *  ${INSTALL}/usr/share/pegasus-frontend/themes/gameOS
}
