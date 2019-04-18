# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="gst-libav"
PKG_VERSION="1.15.90"
PKG_SHA256="c4fc89f3e4e2f7155e9a7dea1cd1f1525ba162a3095e9f1e5f7800d976d0a90f"
PKG_LICENSE="GPL"
PKG_SITE="https://gstreamer.freedesktop.org/modules/gst-libav.html"
PKG_URL="https://gstreamer.freedesktop.org/src/gst-libav/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gstreamer gst-plugins-base ffmpeg"
PKG_LONGDESC="GStreamer plugin for the FFmpeg libav library"
