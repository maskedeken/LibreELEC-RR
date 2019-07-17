# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="slang-shaders-lr"
PKG_VERSION="201fcc8513d8018722bcab2ab1d0791fe95bb8d4"
PKG_SHA256="3c77b5cb5a2fbbd4bc4968e27459342f54f5dca0fdac3ce684a23f0764aa8c3a"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="https://github.com/libretro/slang-shaders/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Vulkan GLSL RetroArch shader system"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="$INSTALL/usr/share/retroarch/shaders/Vulkan-Shaders"
}
