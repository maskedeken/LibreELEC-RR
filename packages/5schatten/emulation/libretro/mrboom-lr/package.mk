# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mrboom-lr"
PKG_VERSION="7a36164d08c4e86509e384dbda6eebeae5ee6166" # v4.7
PKG_SHA256="1a8396591d65e6d9d7bcc7d43f89fffb5223bc17b944d075679ec6942afade26"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/mrboom-libretro"
PKG_URL="https://github.com/libretro/mrboom-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Mr.Boom is an 8 player Bomberman clone for RetroArch/Libretro"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto"

PKG_LIBNAME="mrboom_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  # Disable NEON otherwise build fails
  if target_has_feature neon; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/config/retroarch/playlists
  mkdir -p ${INSTALL}/usr/lib/libretro

  #create Retroarch Playlist
  cp ${PKG_DIR}/files/*   ${INSTALL}/usr/config/retroarch/playlists
  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  cp -v ${PKG_LIBPATH}    ${INSTALL}/usr/lib/libretro/
}
