# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="lr-fbalpha"
PKG_VERSION="83fe5899642609df14e726be8794de549e002afb"
PKG_SHA256="ec18d88e5a34fab7e5aa77718bdba9e7f33eb72e3a6eff47d81f2bf73b88b01c"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fbalpha"
PKG_URL="https://github.com/libretro/fbalpha/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="A libretro port of Final Burn Alpha for Romset v0.2.97.44"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="fbalpha_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-f makefile.libretro GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${PROJECT}" = "RPi" ]; then
    case ${DEVICE} in
      RPi)
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        ;;
      RPi2)
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
        ;;
    esac
  else
    # NEON Support ?
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
    fi
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
