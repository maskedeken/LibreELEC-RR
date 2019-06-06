# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="strace-system"
PKG_VERSION="5.1"
PKG_SHA256="f5a341b97d7da88ee3760626872a4899bf23cf8dee56901f114be5b1837a9a8b"
PKG_LICENSE="BSD"
PKG_SITE="https://strace.io/"
PKG_URL="https://strace.io/files/${PKG_VERSION}/strace-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="strace is a diagnostic, debugging and instructional userspace utility"
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/bin/strace-graph
}
