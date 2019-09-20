# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mame2016"
PKG_VERSION="ea4c1ffa75eb3fb0096158b71706b8b84d86d12c"
PKG_SHA256="71916b18794d854a420cf317ceb95d5f1dad7a142bf7717d5cdab4ff1bf991f7"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2016-libretro"
PKG_URL="https://github.com/libretro/mame2016-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Late 2016 version of MAME (0.174) for libretro. Compatible with MAME 0.174 romsets."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto-parallel"

PKG_LIBNAME="mamearcade2016_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

make_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_NOASM="1"
  else
    PKG_NOASM="0"
  fi

  if [ "${ARCH}" = "x86_64" ]; then
    PKG_PTR64="1"
  else
    PKG_PTR64="0"
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="${ARCH}" DISTRO="debian-stable" \
       CROSS_BUILD="1" OVERRIDE_CC="${CC}" OVERRIDE_CXX="${CXX}" \
       PTR64="${PKG_PTR64}" NOASM="${PKG_NOASM}" TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="${ARCH}" RETRO=1 OSD="retro" GIT_VERSION=${PKG_VERSION:0:7}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/mame2016_libretro.so
}
