# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="patchelf"
PKG_VERSION="0.10"
PKG_SHA256="b3cb6bdedcef5607ce34a350cf0b182eb979f8f7bc31eae55a93a70a3f020d13"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://nixos.org/patchelf.html"
PKG_URL="https://github.com/NixOS/patchelf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_LONGDESC="A small utility to modify the dynamic linker and RPATH of ELF executables."
PKG_TOOLCHAIN="configure"

pre_configure(){
  ./bootstrap.sh
}
