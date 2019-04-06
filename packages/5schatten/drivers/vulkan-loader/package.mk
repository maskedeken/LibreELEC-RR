# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="vulkan-loader"
PKG_VERSION="c2c2abeb6392f0de1ba16bbe6206adb071322be4" # 1.1.102+
PKG_SHA256="e7c4e0ce342c7517bdb167a4ec5d451eec75433b57e9764f5cf740ad07d88939"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Loader"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host vulkan-headers libXrandr"
PKG_LONGDESC="Vulkan Installable Client Driver (ICD) Loader."

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTS=Off \
                       -DBUILD_WSI_WAYLAND_SUPPORT=Off"

