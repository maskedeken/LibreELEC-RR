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

pre_configure_target() {
  PKG_MESON_OPTS_TARGET="-Dx11_backend=true \
                         -Dwayland_backend=false \
                         -Dxinerama=no \
                         -Dprint_backends=auto \
                         -Dintrospection=false \
                         -Ddemos=false \
                         -Dexamples=false \
                         -Dtests=false \
                         -Dbuiltin_immodules=yes"

  export PKG_CONFIG_PATH="$(get_build_dir pango)/.${TARGET_NAME}/meson-private:$(get_build_dir gdk-pixbuf)/.${TARGET_NAME}/meson-private:$(get_build_dir shared-mime-info)/.${TARGET_NAME}:$(get_build_dir libXcursor)/.${TARGET_NAME}"
  export TARGET_CFLAGS="${TARGET_CFLAGS} -Wno-missing-include-dirs -I$(get_build_dir pango) -I$(get_build_dir pango)/pango -I$(get_build_dir pango)/.${TARGET_NAME} -I$(get_build_dir libXcursor)/.${TARGET_NAME}/include"
  export TARGET_LDFLAGS="${TARGET_LDFLAGS} -L$(get_build_dir pango)/.${TARGET_NAME}/pango -L$(get_build_dir libXcursor)/.${TARGET_NAME}/src/.libs"
  export GDK_PIXBUF_PIXDATA="$SYSROOT_PREFIX/usr/bin/gdk-pixbuf-pixdata"
}

makeinstall_target() {
  #install libs for chrome
  mkdir -p ${INSTALL}/usr/lib
    cp -PR gtk/libgtk-3.so* ${INSTALL}/usr/lib
    cp -PR gdk/libgdk-3.so* ${INSTALL}/usr/lib
}
