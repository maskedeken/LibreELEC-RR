# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="lr-flycast"
PKG_VERSION="4d3a6e2b46868c119261041f913ee55c51bfc9d0"
PKG_SHA256="c3f6718af68bac9ba791592c561e0ea36f92b565160db20a35fd981bd5e4f88a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="https://github.com/libretro/flycast/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="flycast_libretro.so"
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
