# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libevent"
PKG_VERSION="2.1.11-stable"
PKG_SHA256="229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e"
PKG_LICENSE="BSD"
PKG_SITE="http://libevent.org/"
PKG_URL="https://github.com/libevent/libevent/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl zlib"
PKG_LONGDESC="Event notification library."

PKG_CMAKE_OPTS_TARGET="-DEVENT__DISABLE_DEBUG_MODE=on \
                       -DEVENT__DISABLE_BENCHMARK=on \
                       -DEVENT__DISABLE_TESTS=on \
                       -DEVENT__LIBRARY_TYPE=SHARED \
                       -DEVENT__DISABLE_SAMPLES=on"
