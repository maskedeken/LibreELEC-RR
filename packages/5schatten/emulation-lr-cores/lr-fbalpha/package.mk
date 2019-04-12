# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="lr-fbalpha"
PKG_VERSION="ac469c4e57fca61e1a63d8ee9def165b9a17a5d4"
PKG_SHA256="a4ffe102e79ff8d4b39fbd32022bbe3e92e9b80d56bedd9eceaf9a835fbfb09e"
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
