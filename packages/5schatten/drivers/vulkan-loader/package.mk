# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="vulkan-loader"
PKG_VERSION="1.1.106"
PKG_SHA256="d48632a5459d21ee5d421cb6ef1611cc263d33cca3ef90d0f598f73d24dfc206"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Loader"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host vulkan-headers"
PKG_LONGDESC="Vulkan Installable Client Driver (ICD) Loader."

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libX11 libXrandr libxcb"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTS=Off \
                         -DBUILD_WSI_WAYLAND_SUPPORT=Off"

  # Mali Vulkan support
  if [ ! "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=Off \
                             -DBUILD_WSI_XLIB_SUPPORT=Off"
  fi
}
