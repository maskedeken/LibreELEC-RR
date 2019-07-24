# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="hatari"
PKG_VERSION="c6979eb165d539e58b5adfbf7059d6d681fe1499" #v2.2.1+
PKG_SHA256="33124aab9f9c1d39820596a5bf9bb89a6d5d7a7df5ed0a9f0c814bad7205ae58"
PKG_LICENSE="GPL"
PKG_SITE="https://hatari.tuxfamily.org/"
PKG_URL="https://github.com/hatari/hatari/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc systemd alsa-lib SDL2-system portaudio zlib capsimg libpng"
PKG_LONGDESC="Hatari is an Atari ST/STE/TT/Falcon emulator"
PKG_BUILD_FLAGS="+lto"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server unclutter-xfixes"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DCMAKE_SKIP_RPATH=ON \
                         -DDATADIR="/usr/config/hatari" \
                         -DBIN2DATADIR="../../storage/.config/hatari" \
                         -DCAPSIMAGE_INCLUDE_DIR=${PKG_BUILD}/src/include \
                         -DCAPSIMAGE_LIBRARY=${PKG_BUILD}/libcapsimage.so.5.1"

  # copy IPF Support Library include files
  mkdir -p ${PKG_BUILD}/src/includes/caps5/
  cp -R $(get_build_dir capsimg)/LibIPF/* ${PKG_BUILD}/src/includes/caps5/
  cp -R $(get_build_dir capsimg)/Core/CommonTypes.h ${PKG_BUILD}/src/includes/caps5/
  cp -R $(get_build_dir capsimg)/CAPSImg/libcapsimage.so.5.1 ${PKG_BUILD}/

  # add library search path for loading libcapsimage library
  LDFLAGS+=" -Wl,-rpath='${PKG_BUILD}'"
}

makeinstall_target() {
  # create directories
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/config/hatari

  # copy config files  
  touch ${INSTALL}/usr/config/hatari/hatari.nvram
  cp -R ${PKG_DIR}/config/* ${INSTALL}/usr/config/hatari

  # copy binary & start script
  cp -v src/hatari ${INSTALL}/usr/bin
  cp -R ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/
}
