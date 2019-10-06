# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="gst-omx"
PKG_VERSION="1.16.1"
PKG_SHA256="cbf54121a2cba575d460833e8132265781252ce32cf5b8f9fa8753e42ab24bb2"
PKG_LICENSE="LGPL-2.1"
PKG_SITE="https://gstreamer.freedesktop.org/modules/gst-omx.html"
PKG_URL="https://gstreamer.freedesktop.org/src/gst-omx/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain bcm2835-driver gstreamer gst-plugins-base"
PKG_LONGDESC="OpenMax-based decoder and encoder elements for GStreamer."
PKG_TOOLCHAIN="configure"

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--with-omx-target=rpi"
  CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/IL"
}
