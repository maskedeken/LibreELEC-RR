# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="pegasus-theme-gameOS"
PKG_VERSION="e4cfdaece6991a908927d5bca760a6c67645022e" # v0.6.6
PKG_SHA256="9a1e1cc2749cf6c7d0a3398a68368273c3dc607c2e55f2ee3441290d525613b5"
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
