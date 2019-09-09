# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="bsnes"
PKG_VERSION="68a71a84a016aa479dce3a3493411191090a208e"
PKG_SHA256="78b9b996dcdeed918f3b43e094e823170cf045ae7d0b25a5502f5b91491c808e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes"
PKG_URL="https://github.com/libretro/bsnes/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="bsnes is a multi-platform Super Nintendo (Super Famicom) emulator that focuses on performance, features, and ease of use."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="bsnes_hd_libretro.so"
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
