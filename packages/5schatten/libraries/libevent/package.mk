# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libevent"
PKG_VERSION="2.1.10-stable"
PKG_SHA256="52c9db0bc5b148f146192aa517db0762b2a5b3060ccc63b2c470982ec72b9a79"
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
