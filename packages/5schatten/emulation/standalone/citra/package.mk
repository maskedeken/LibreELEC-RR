# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="citra"
PKG_VERSION="8fa6be5b1516f7b8b5447a3fb88f677212da28d2"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/citra-emu/citra"
PKG_URL="https://github.com/citra-emu/citra.git"
PKG_DEPENDS_TARGET="toolchain linux glibc systemd dbus zlib pulseaudio ffmpeg mesa xorg-server boost qt-everywhere SDL2-system unclutter-xfixes"
PKG_LONGDESC="A Nintendo 3DS Emulator"
GET_HANDLER_SUPPORT="git"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DENABLE_SDL2=1 \
                         -DENABLE_QT=1 \
                         -DENABLE_CUBEB=0 \
                         -DENABLE_FFMPEG=1 \
                         -DCMAKE_BUILD_TYPE=\"Release\" \
                         -DENABLE_WEB_SERVICE=0 \
                         -DCMAKE_NO_SYSTEM_FROM_IMPORTED=1 \
                         -DCMAKE_VERBOSE_MAKEFILE=1"

  # Workaround for GCC 9.1.0 https://github.com/citra-emu/citra/issues/4766
  CXXFLAGS+=" -DFMT_USE_USER_DEFINED_LITERALS=0"
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

post_makeinstall_target() {
  # Copy scripts & config files
  mkdir -p ${INSTALL}/usr/config/citra-emu
  cp -a  ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/
  cp -PR ${PKG_DIR}/config/*  ${INSTALL}/usr/config/citra-emu/
  cp -PR ${PKG_DIR}/files/*   ${INSTALL}/usr/config/citra-emu/
  
  # Clean up
  safe_remove ${INSTALL}/usr/share/
  safe_remove ${INSTALL}/usr/bin/citra
}
