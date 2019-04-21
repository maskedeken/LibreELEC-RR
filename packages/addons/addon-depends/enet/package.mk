# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="enet"
PKG_VERSION="0eaf48eeb0d94a18d079378d8b76d588832ce838"
PKG_SHA256="f7c29eef161414f7f2c2191d256b03c191c370961a9960072858fa7feed8590e"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/lsalzman/enet"
PKG_URL="https://github.com/lsalzman/enet/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ENet's purpose is to provide a relatively thin, simple and robust network communication layer on top of UDP (User Datagram Protocol)"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared"

post_makeinstall_target() {
  rm -r ${INSTALL}
}
