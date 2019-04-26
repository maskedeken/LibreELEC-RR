# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="lr-yabasanshiro"
PKG_VERSION="d92cf2262b283cfef3e01f76a622a98435ff138c"
PKG_SHA256="da076144cbf18d88e58a0527cfd9337d0ba6923392dd32c5cfe85aeeff76b0a8"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="YabaSanshiro Sega Saturn emulator libretro port."

PKG_TOOLCHAIN="make"

PKG_LIBNAME="yabasanshiro_libretro.so"
PKG_LIBPATH="yabause/src/libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET=" -C yabause/src/libretro GIT_VERSION=${PKG_VERSION:0:7}"

configure_package() {
  # Apply project specific patches
  PKG_PATCH_DIRS="${PROJECT}"
}

pre_configure_target() {
  case ${PROJECT} in
    Rockchip)
      if [ "${DEVICE}" = "RK3399" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=rockpro64"
      fi
    ;;
  esac
}

pre_make_target() {
  make CC=${HOST_CC} -C yabause/src/libretro generate-files
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
