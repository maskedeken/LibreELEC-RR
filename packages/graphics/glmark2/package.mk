# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glmark2"
PKG_VERSION="7632c2e2677ef01e44af758823c2fffcced22524"
PKG_SHA256="c0fb0fb2f62d05f229466a4c1cbb902816595b0a5ed860de46f763533c515e6c"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/glmark2/glmark2"
PKG_URL="https://github.com/glmark2/glmark2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="glmark2 is an OpenGL 2.0 and ES 2.0 benchmark"
PKG_TOOLCHAIN="manual"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  if [ "${DISPLAYSERVER}" = "weston" ]; then
    PKG_CONFIGURE_OPTS_TARGET="--with-flavors=wayland-glesv2"
  elif [ "${OPENGLES}" = "bcm2835-driver" ]; then
    PKG_CONFIGURE_OPTS_TARGET="--with-flavors=dispmanx-glesv2"
  else
    PKG_CONFIGURE_OPTS_TARGET="--with-flavors=drm-glesv2"
  fi
elif [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CONFIGURE_OPTS_TARGET="--with-flavors=x11-gl"
  else
    PKG_CONFIGURE_OPTS_TARGET="--with-flavors=drm-gl"
  fi
fi

configure_target() {
  ./waf configure ${PKG_CONFIGURE_OPTS_TARGET} --prefix=/usr
}

make_target() {
  ./waf
}

makeinstall_target() {
  ./waf install --destdir=${INSTALL}
}
