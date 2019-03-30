# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="lr-prboom"
PKG_VERSION="b4353d83665e4558cd7ea956346ec62d8750c22f"
PKG_SHA256="3b8164ed12f007fee2468fcbad63909f68ae9eb4c0063a52e7300e1badfafa51"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="https://github.com/libretro/libretro-prboom/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Port of prboom to libretro - plays Doom, Doom II, Final Doom and other Doom IWAD mods."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="prboom_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/lib/libretro
  mkdir -p $INSTALL/usr/share/prboom

  cp $PKG_DIR/scripts/* $INSTALL/usr/bin
  cp $PKG_BUILD/prboom.wad $INSTALL/usr/share/prboom
  cp $PKG_LIBPATH $INSTALL/usr/lib/libretro/
}


