# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="gst-plugins-base"
PKG_VERSION="1.15.90"
PKG_SHA256="c87fad68f8d5313b77b3473ce5433dcd0d931327635012b226ce2a109129a7a3"
PKG_LICENSE="GPL"
PKG_SITE="https://gstreamer.freedesktop.org/modules/gst-plugins-base.html"
PKG_URL="https://gstreamer.freedesktop.org/src/gst-plugins-base/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gstreamer"
PKG_LONGDESC="Base GStreamer plugins and helper libraries"

PKG_MESON_OPTS_TARGET="-Dexamples=disabled \
                       -Dtests=disabled \
                       -Dgtk_doc=disabled \
                       -Dnls=disabled"

post_makeinstall_target(){
  # Clean up
  rm -rf ${INSTALL}/usr/bin
}
