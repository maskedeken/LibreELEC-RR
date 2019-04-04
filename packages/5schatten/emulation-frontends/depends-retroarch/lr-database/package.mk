# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="lr-database"
PKG_VERSION="0331956b9073378bff6995e0b00c5db3c85bf95e"
PKG_SHA256="5cb48a5bee0149cca8558befee471c628fa5c0940b8a7c3d08d7344e9994d029"
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
