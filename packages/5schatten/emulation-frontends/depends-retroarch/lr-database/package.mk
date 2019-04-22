# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="lr-database"
PKG_VERSION="d891a0d6da6e87b60a36db4acd28b0e3f41b3317"
PKG_SHA256="9c91efc179e790cd8e86b7804d27ac094ae1bc3cb5c88f7f520def159a8f152e"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-database"
PKG_URL="https://github.com/libretro/libretro-database/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch database containing cheatcode files, content data files, etc."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/database"
}

post_makeinstall_target() {
  # Remove common unnecessary databases
  rm ${INSTALL}/usr/share/retroarch/database/rdb/MAME.rdb
  rm ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2000.rdb
  rm ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2003.rdb
  rm ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2015.rdb
  rm ${INSTALL}/usr/share/retroarch/database/rdb/Microsoft*Xbox*.rdb
  rm ${INSTALL}/usr/share/retroarch/database/rdb/Sony*PlayStation*3*.rdb

  # Remove additional unnecessary databases
  if [ ! "${PROJECT}" = "Generic" ]; then
    rm ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2016.rdb
    rm ${INSTALL}/usr/share/retroarch/database/rdb/Nintendo*GameCube*.rdb
    rm ${INSTALL}/usr/share/retroarch/database/rdb/Nintendo*Nintendo*3DS*.rdb
    rm ${INSTALL}/usr/share/retroarch/database/rdb/Nintendo*Wii*.rdb
  elif [ "${PROJECT}" = "Generic" ]; then
    rm ${INSTALL}/usr/share/retroarch/database/rdb/MAME*2010.rdb
  fi
}
