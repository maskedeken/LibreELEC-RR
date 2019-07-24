# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="unclutter-xfixes"
PKG_VERSION="1.5"
PKG_SHA256="35c75ad24be989dd6708db1d9ce9b2a2f814b80638c0633cdb075c6df090ed11"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/Airblader/unclutter-xfixes"
PKG_URL="https://github.com/Airblader/unclutter-xfixes/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 libXi libXfixes libev-system"
PKG_LONGDESC="This is a rewrite of the popular tool unclutter, but using the x11-xfixes extension."

post_install() {
  enable_service unclutter.service
}
