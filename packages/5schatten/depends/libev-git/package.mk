# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libev-git"
PKG_VERSION="4.25"
PKG_SHA256="ef2b4031e03b540c510ae373949bcbb2e4335d1bdb20e8975a7ae4153464c99f"
PKG_LICENSE="GPL"
PKG_SITE="http://libev.schmorp.de"
PKG_URL="https://git.lighttpd.net/libev.git/snapshot/libev-rel-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A full-featured and high-performance event loop."
PKG_TOOLCHAIN="configure"

pre_configure_target() {
  do_autoreconf
}
