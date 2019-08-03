# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="opus-system"
PKG_VERSION="1.3"
PKG_SHA256="4f3d69aefdf2dbaf9825408e452a8a414ffc60494c70633560700398820dc550"
PKG_LICENSE="BSD"
PKG_SITE="http://www.opus-codec.org"
PKG_URL="https://archive.mozilla.org/pub/opus/opus-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Codec designed for interactive speech and audio transmission over the Internet."

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET=""

  if [ "${TARGET_ARCH}" = "arm" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-fixed-point"
  else
    PKG_CONFIGURE_OPTS_TARGET+=" --disable-fixed-point"
  fi
}
