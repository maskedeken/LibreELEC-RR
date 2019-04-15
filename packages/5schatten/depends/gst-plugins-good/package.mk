# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="gst-plugins-good"
PKG_VERSION="1.15.90"
PKG_SHA256="23330ddba08177f6b279b38e0d88c10a5af5ca4b5550e5fd70a7f0d9db6b086a"
PKG_LICENSE="GPL"
PKG_SITE="https://gstreamer.freedesktop.org/modules/gst-plugins-good.html"
PKG_URL="https://gstreamer.freedesktop.org/src/gst-plugins-good/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gstreamer gst-plugins-base"
PKG_LONGDESC="Good GStreamer plugins and helper libraries"

PKG_MESON_OPTS_TARGET="-Dgdk-pixbuf=disabled \
                       -Dtaglib=disabled \
                       -Dexamples=disabled \
                       -Dtests=disabled \
                       -Dnls=disabled"

post_makeinstall_target(){
  # Clean up
  rm -rf ${INSTALL}/usr/share
}
