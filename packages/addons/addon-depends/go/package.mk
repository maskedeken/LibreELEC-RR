# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="go"
PKG_VERSION="1.11.6"
PKG_SHA256="d14417e54e22da2980ef0b1f59f0e26a46888e1e5796871ef159bd0e73682125"
PKG_LICENSE="BSD"
PKG_SITE="https://golang.org"
PKG_URL="https://github.com/golang/go/archive/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_LONGDESC="An programming language that makes it easy to build simple, reliable, and efficient software."
PKG_TOOLCHAIN="manual"

####################################################################
# On Fedora `dnf install golang` will install go to /usr/lib/golang
#
# On Ubuntu you need to install golang:
# $ sudo apt install golang-go
####################################################################

configure_host() {
  export GOOS=linux
  export GOROOT_FINAL=$TOOLCHAIN/lib/golang
  if [ -x /usr/lib/go/bin/go ]; then
    export GOROOT_BOOTSTRAP=/usr/lib/go
  else
    export GOROOT_BOOTSTRAP=/usr/lib/golang
  fi
  export GOARCH=amd64
}

make_host() {
  cd $PKG_BUILD/src
  bash make.bash --no-banner
}

pre_makeinstall_host() {
  # need to cleanup old golang version when updating to a new version
  rm -rf $TOOLCHAIN/lib/golang
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/golang
  cp -av $PKG_BUILD/* $TOOLCHAIN/lib/golang/
}
