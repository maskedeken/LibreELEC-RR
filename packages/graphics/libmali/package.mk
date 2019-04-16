# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmali"
PKG_VERSION="ad48c3e035b8402f1dd2608b0455ab301b9bc073"
PKG_SHA256="ff6fc94b54298656270ce7d790ae4a4b1322b602dd04283b121c69572cc37c60"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/LibreELEC/libmali"
PKG_URL="https://github.com/5schatten/libmali/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="OpenGL ES user-space binary for the ARM Mali GPU family"

PKG_DEPENDS_TARGET="libdrm"

if [ "$MALI_FAMILY" = "t620" -o "$MALI_FAMILY" = "t720" -o "$MALI_FAMILY" = "g52" ]; then
  PKG_DEPENDS_TARGET+=" wayland"
fi

PKG_CMAKE_OPTS_TARGET="-DMALI_VARIANT=$MALI_FAMILY"

if [ -n "$MALI_REVISION" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DMALI_REVISION=$MALI_REVISION"
fi

if [ "$TARGET_ARCH" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DMALI_ARCH=aarch64-linux-gnu"
fi
