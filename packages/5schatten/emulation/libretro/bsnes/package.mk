# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="bsnes"
PKG_VERSION="ccef4445618c45aae755c85348c5008962d280f4"
PKG_SHA256="35937da6729a0a73f0d9bcb01028680ab73b97a8b4fc8514ba90b1fdcf4207bb"
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
