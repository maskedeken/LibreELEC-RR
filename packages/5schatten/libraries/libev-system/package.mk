# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libev-system"
PKG_VERSION="4.27"
PKG_SHA256="4c91eaffcf2dde23aa7b459bd9905fea81df7547106a47cfd6eba342c5ce3503"
PKG_LICENSE="GPL"
PKG_SITE="http://libev.schmorp.de"
PKG_URL="https://git.lighttpd.net/libev.git/snapshot/libev-rel-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A full-featured and high-performance event loop."
PKG_TOOLCHAIN="configure"

pre_configure_target() {
  do_autoreconf
}
