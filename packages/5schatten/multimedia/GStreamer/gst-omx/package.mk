# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="gst-omx"
PKG_VERSION="1.16.0"
PKG_SHA256="fef77cddc02784608451c46b9def880b63230a246decf8900f2da2ed54a8af4a"
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
