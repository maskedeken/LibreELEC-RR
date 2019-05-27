# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="lr-mesen"
PKG_VERSION="96851e6c7a881e40322a1a3e33b5aa4fcc0acbce" # 0.9.7+
PKG_SHA256="c335083fc2143cbbefacc28726cd8ecc3699cbf11b9563332d357084cfebc18f"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/SourMesen/Mesen"
PKG_URL="https://github.com/SourMesen/Mesen/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Mesen is a cross-platform (Windows & Linux) NES/Famicom emulator built in C++ and C#"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="mesen_libretro.so"
PKG_LIBPATH="Libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C Libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
