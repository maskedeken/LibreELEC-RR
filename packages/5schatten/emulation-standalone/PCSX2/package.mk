# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="PCSX2"
PKG_VERSION="1.5.0-dev"
PKG_DOCKER_IMAGE_VERSION="1.0.2"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/PCSX2/pcsx2"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PCSX2 is a free and open-source PlayStation 2 (PS2) emulator."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
 mkdir -p $INSTALL/usr/bin
 mkdir -p $INSTALL/usr/config

 cp -r $PKG_DIR/scripts/* $INSTALL/usr/bin/
 cp -r $PKG_DIR/config/* $INSTALL/usr/config/
 sed -e "s/PCSX2_DOCKER_IMAGE_VERSION=.*/PCSX2_DOCKER_IMAGE_VERSION=version-${PKG_DOCKER_IMAGE_VERSION}/" -i ${INSTALL}/usr/bin/pcsx2.start
}
