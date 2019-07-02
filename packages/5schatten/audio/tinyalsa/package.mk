# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="tinyalsa"
PKG_VERSION="9ec09d5124bc1d1c081d8c910ace663e1f398649"
PKG_SHA256="c028871db1b778a518f1269ae04b3e23675a5b7f82b8e0d9fb9532718ca8e5c1"
PKG_LICENSE="AOSP"
PKG_SITE="https://github.com/tinyalsa/tinyalsa"
PKG_URL="https://github.com/tinyalsa/tinyalsa/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TinyALSA is a small library to interface with ALSA in the Linux kernel."

PKG_MESON_OPTS_TARGET="-Ddocs=disabled \
                       -Dexamples=disabled \
                       -Dutils=disabled"
