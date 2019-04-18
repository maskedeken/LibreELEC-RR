# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="gstreamer"
PKG_VERSION="1.15.90"
PKG_SHA256="f71fe61f6b90b5a1ded99d5e5a47b90f2855dbcad115863d4356a9d330f6bbb6"
PKG_LICENSE="GPL"
PKG_SITE="https://gstreamer.freedesktop.org"
PKG_URL="https://gstreamer.freedesktop.org/src/gstreamer/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="GStreamer open-source multimedia framework core library"

PKG_MESON_OPTS_TARGET="-Dlibunwind=disabled \
                       -Dgtk_doc=disabled \
                       -Dexamples=disabled \
                       -Dtests=disabled \
                       -Dnls=disabled"
