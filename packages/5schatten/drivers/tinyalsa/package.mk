# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="tinyalsa"
PKG_VERSION="809054250a32b6b1f0c416bf820ef807b98b740f"
PKG_SHA256="290b596887ffceef5ac3fc310fc3d93b124777d6685912a98173ec2cdf21b53d"
PKG_LICENSE="AOSP"
PKG_SITE="https://github.com/tinyalsa/tinyalsa"
PKG_URL="https://github.com/tinyalsa/tinyalsa/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TinyALSA is a small library to interface with ALSA in the Linux kernel."

PKG_MESON_OPTS_TARGET="-Ddocs=disabled \
                       -Dexamples=disabled \
                       -Dutils=disabled"
