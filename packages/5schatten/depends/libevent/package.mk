# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libevent"
PKG_VERSION="2.1.9-beta"
PKG_SHA256="0ab250abac1def3d1e20e23e05ce827efa81db65c9004ccfff58d16404e3e369"
PKG_LICENSE="BSD"
PKG_SITE="http://libevent.org/"
PKG_URL="https://github.com/libevent/libevent/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl zlib"
PKG_LONGDESC="Event notification library."

PKG_CMAKE_OPTS_TARGET="-DEVENT__DISABLE_DEBUG_MODE=on \
                       -DEVENT__DISABLE_BENCHMARK=on \
                       -DEVENT__DISABLE_TESTS=on \
                       -DEVENT__DISABLE_SAMPLES=on"

makeinstall_target() {
 :
}
