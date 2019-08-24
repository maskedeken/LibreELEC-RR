# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="beetle-saturn"
PKG_VERSION="35e8cd757fde92dea66a42583961bf3e6deb24b8"
PKG_SHA256="fe9605fee04afae3b54de31dad0135a5bd253744488fa6455811a6eb28d88c3b"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/beetle-saturn-libretro"
PKG_URL="https://github.com/libretro/beetle-saturn-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Standalone port of Mednafen Saturn to the libretro API."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="mednafen_saturn_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
