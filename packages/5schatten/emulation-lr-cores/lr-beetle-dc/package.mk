# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="lr-beetle-dc"
PKG_VERSION="78bc44ab932920e6c318bafeb262f4f941529189"
PKG_SHA256="4de36fa3df5b27b5407e7590d31e34912c1b5f0fad9612a0b1222c092c59e68c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-dc"
PKG_URL="https://github.com/libretro/beetle-dc/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Beetle DC is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="beetledc_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="HAVE_OPENMP=0 GIT_VERSION=${PKG_VERSION:0:7} WITH_DYNAREC=${ARCH}"

configure_package() {
  # Apply project specific patches
  PKG_PATCH_DIRS="${PROJECT}"

  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

pre_configure_target() {
  case ${PROJECT} in
    Generic)
      PKG_MAKE_OPTS_TARGET+=" HAVE_OIT=1"
      ;;
    RPi)
      if [ "${DEVICE}" = "RPi2" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
      else
        PKG_MAKE_OPTS_TARGET+=" platform=rpi"
      fi
      ;;
    Rockchip)
      if [ "${DEVICE}" = "RK3399" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=rockpro64"
      else
        PKG_MAKE_OPTS_TARGET+=" platform=tinkerboard"
      fi
      ;;
    *)
      if [ "${ARCH}" = "arm" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        # OpenGL ES support
        if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
          PKG_MAKE_OPTS_TARGET+="-gles"
        fi
        # ARM NEON support
        if target_has_feature neon; then
          PKG_MAKE_OPTS_TARGET+="-neon"
        fi
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
