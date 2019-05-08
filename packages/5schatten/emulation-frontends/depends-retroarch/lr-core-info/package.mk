# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="lr-core-info"
PKG_VERSION="f07499692853d46182ba924b524e2d9a2ba3ecb3" # v1.7.7
PKG_SHA256="ef7f147435836238b5902c05ada7e0f342a1d524b62ba638a8ef0f4cd169f01b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="https://github.com/libretro/libretro-core-info/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro's core info files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/coreinfo"
}
