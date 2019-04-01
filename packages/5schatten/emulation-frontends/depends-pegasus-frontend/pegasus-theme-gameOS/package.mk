# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="pegasus-theme-gameOS"
PKG_VERSION="3f72952c867aece5b5cb5c37cc47d13621263dba" # v0.5+
PKG_SHA256="17b56afecd2787e73edde000adf7013dd6af6f8afda921079d5541420053da82"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/PlayingKarrde/gameOS"
PKG_URL="https://github.com/PlayingKarrde/gameOS/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="gameOS theme for Pegasus Frontend"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/pegasus-frontend/themes/gameOS
  cp -r *  $INSTALL/usr/share/pegasus-frontend/themes/gameOS
}
