# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Trond Haugland (trondah @ gmail.com)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gtk3"
PKG_VERSION="3.24.10"
PKG_SHA256="35a8f107e2b90fda217f014c0c15cb20a6a66678f6fd7e36556d469372c01b03"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/gtk+/${PKG_VERSION:0:4}/gtk+-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain at-spi2-atk atk cairo gdk-pixbuf glib libX11 libXi libXrandr libepoxy pango"
PKG_LONGDESC="A library for creating graphical user interfaces for the X Window System."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--disable-cups \
                           --disable-debug \
                           --enable-explicit-deps=no \
                           --disable-glibtest \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-man \
                           --enable-modules \
                           --disable-papi \
                           --disable-xinerama \
                           --enable-xkb"

pre_configure_target() {
  LIBS+=" -lXcursor"
  export PKG_CONFIG_PATH="$(get_build_dir pango)/.${TARGET_NAME}/meson-private:$(get_build_dir gdk-pixbuf)/.${TARGET_NAME}/meson-private:$(get_build_dir shared-mime-info)/.${TARGET_NAME}"
  export CFLAGS="${CFLAGS} -I$(get_build_dir pango) -I$(get_build_dir pango)/.${TARGET_NAME} -L$(get_build_dir pango)/.${TARGET_NAME}/pango"
  export GLIB_COMPILE_RESOURCES=glib-compile-resources GLIB_MKENUMS=glib-mkenums GLIB_GENMARSHAL=glib-genmarshal
}

makeinstall_target() {
  #install libs for chrome to target
  mkdir -p ${INSTALL}/usr/lib
    cp -PR gtk/.libs/libgtk-3.so* ${INSTALL}/usr/lib
    cp -PR gdk/.libs/libgdk-3.so* ${INSTALL}/usr/lib
}
