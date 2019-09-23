# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="glew-cmake"
PKG_VERSION="2.1.0"
PKG_SHA256="e1dd68b24dafa1d7c26fb59a38a3daa7ca749962104c486eaa0751f967d7f8c4"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/Perlmint/glew-cmake"
PKG_URL="https://github.com/Perlmint/glew-cmake/archive/glew-cmake-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libXi"
PKG_LONGDESC="The OpenGL Extension Wrangler Library (GLEW) is a cross-platform open-source C/C++ extension loading library."

PKG_CMAKE_OPTS_TARGET="-D glew-cmake_BUILD_STATIC=off \
                       -D glew-cmake_BUILD_MULTI_CONTEXT=off"
