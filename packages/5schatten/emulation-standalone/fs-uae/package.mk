# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="fs-uae"
PKG_VERSION="9770cb963b3abbb859220ecf66cb2478dd1506a8" # 2.9.8dev2+
PKG_SHA256="6054c721338381a809298784005419ba13b1cb4a1c18286317f25d7a9895744c"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/FrodeSolheim/fs-uae"
PKG_URL="https://github.com/FrodeSolheim/fs-uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc glib SDL2-git glew glu libmpeg2 libXi openal-soft capsimg zlib libpng"
PKG_LONGDESC="FS-UAE amiga emulator."
PKG_TOOLCHAIN="autotools"

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
