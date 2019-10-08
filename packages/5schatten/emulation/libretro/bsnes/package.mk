# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="bsnes"
PKG_VERSION="e71da4d8c86d561445781cc00b6ac83de12e7d2d"
PKG_SHA256="a0677b9359304b8840f16813572897c8e733008de07d9628311c54226bb7092c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes"
PKG_URL="https://github.com/libretro/bsnes/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="bsnes is a multi-platform Super Nintendo (Super Famicom) emulator that focuses on performance, features, and ease of use."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="bsnes_libretro.so"
PKG_LIBPATH="bsnes/out/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C bsnes \
                      compiler=${TOOLCHAIN}/bin/${TARGET_NAME}-g++ \
                      target=libretro \
                      platform=linux \
                      binary=library \
                      openmp=false"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
