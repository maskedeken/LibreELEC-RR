# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="lr-fuse"
PKG_VERSION="98b9ba17bad15a6ed60831f53ba34654b1a1bcde"
PKG_SHA256="43552fc1ca6abee93d53bb616519815a4494339aa1dbc989c732523a8faebcf7"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_URL="https://github.com/libretro/fuse-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="fuse-libretro is an work in progress port of the Fuse Unix Spectrum Emulator to libretro."

PKG_LIBNAME="fuse_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_LIBPATH $INSTALL/usr/lib/libretro/
}
