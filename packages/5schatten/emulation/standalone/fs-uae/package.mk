# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="fs-uae"
PKG_VERSION="31239a79b097728aba9ceeef74d2c135cea49e1c" # 3.0.0
PKG_SHA256="3e91af3a61d7ef2338742ac59b3279c3ca414344c22cd8b2de5051147392f4ad"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/FrodeSolheim/fs-uae"
PKG_URL="https://github.com/FrodeSolheim/fs-uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc glib SDL2-system glew-cmake glu libmpeg2 libXi openal-soft capsimg zlib libpng"
PKG_LONGDESC="FS-UAE amiga emulator."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+lto"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server unclutter-xfixes"
  fi
}

post_unpack() {
  # Copy custom input configs
  cp -rf ${PKG_DIR}/input/* ${PKG_BUILD}/share/fs-uae/input/
}

pre_configure_target() {
  # Fix cross compiling
  export ac_cv_func_realloc_0_nonnull=yes
}

post_makeinstall_target() {
  # Install scripts
  cp -rfv ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/

  # Set up default config directory
  mkdir -p ${INSTALL}/usr/config
  cp -rfv ${PKG_DIR}/config ${INSTALL}/usr/config/fs-uae
  ln -sf /storage/roms/bios/Kickstarts ${INSTALL}/usr/config/fs-uae/Kickstarts

  # Create symlink to capsimg for IPF support
  mkdir -p ${INSTALL}/usr/config/fs-uae/Plugins
  ln -sf /usr/lib/libcapsimage.so.5.1 ${INSTALL}/usr/config/fs-uae/Plugins/capsimg.so

  # Clean up
  safe_remove ${INSTALL}/usr/share/applications
  safe_remove ${INSTALL}/usr/share/icons
  safe_remove ${INSTALL}/usr/share/mime
}
