# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dav1d"
PKG_VERSION="0.2.2"
PKG_SHA256="7695e7920de982c1f25f234b965c99cf6057540a4a3544dd5f40f6e5335c965d"
PKG_LICENSE="BSD"
PKG_SITE="http://www.jbkempf.com/blog/post/2018/Introducing-dav1d"
PKG_URL="https://code.videolan.org/videolan/dav1d/-/archive/${PKG_VERSION}/dav1d-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dav1d is an AV1 decoder :)"

configure_package() {
  if [ "${TARGET_ARCH}" = "x86_64" ]; then
    PKG_DEPENDS_TARGET+=" nasm:host"
  fi
}

pre_configure_target(){
  PKG_MESON_OPTS_TARGET="-Dbuild_tools=false \
                         -Dbuild_tests=false"
}
