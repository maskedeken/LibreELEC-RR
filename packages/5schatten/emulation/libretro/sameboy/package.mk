# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="sameboy"
PKG_VERSION="133914f16690f92c71913543427694d8e6210603"
PKG_SHA256="b3dec9cc36203b73f86c7b9d7e269b482b5619cc18eaad19aab8707818ebd63d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/SameBoy"
PKG_URL="https://github.com/libretro/SameBoy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Gameboy and Gameboy Color emulator written in C"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="sameboy_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET=" -C libretro GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
