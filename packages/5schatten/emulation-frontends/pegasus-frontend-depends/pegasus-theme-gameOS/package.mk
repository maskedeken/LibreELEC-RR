# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="pegasus-theme-gameOS"
PKG_VERSION="78e834c4929ddf69e4a6143daa403338313758a6" # v0.5+
PKG_SHA256="caa7a7e8319be1771d889b54bc8688d33d2a16420b4476cd6b6b69c3ff41f508"
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
