# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="retrofe"
PKG_VERSION="0941199ddec1af942e503e4d27e2a01f4508a2a2" # v0.9.0
PKG_SHA256="8bcea50111fdceeb27eda0eef4cc816a8b845e0b481fd395b9bb94585b77a602"
PKG_LICENSE="GPLv3"
PKG_SITE="http://retrofe.nl/"
PKG_URL="https://bitbucket.org/phulshof/retrofe/get/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc glib SDL2_image SDL2_mixer SDL2_ttf gst-plugins-good"
PKG_LONGDESC="A cross-platform frontend designed for MAME cabinets/game centers/etc. with a focus on simplicity and customization"
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/RetroFE/Source/CMakeLists.txt"

  PKG_CMAKE_OPTS_TARGET="-BRetroFE/Build
                         -DVERSION_MAJOR=0 \
                         -DVERSION_MINOR=0 \
                         -DVERSION_BUILD=0"
}

make_target() {
  cmake --build RetroFE/Build
  python ${PKG_BUILD}/Scripts/Package.py --os=linux --build=full
}

makeinstall_target() {
  # Create directories
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/config/retrofe
  mkdir -p ${INSTALL}/usr/share/retrofe

  # Install RetroFE resources
  cp -rf Artifacts/linux/RetroFE/* ${INSTALL}/usr/config/retrofe
  mv -v  ${INSTALL}/usr/config/retrofe/retrofe ${INSTALL}/usr/bin/
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/retrofe

  # Install scripts
  cp -rf ${PKG_DIR}/scripts/common/*     ${INSTALL}/usr/bin/
  cp -rf ${PKG_DIR}/scripts/${PROJECT}/* ${INSTALL}/usr/bin/

  # Clean up
  safe_remove ${INSTALL}/usr/config/retrofe/README-UBUNTU.txt
  safe_remove ${INSTALL}/usr/config/retrofe/README.txt
}
