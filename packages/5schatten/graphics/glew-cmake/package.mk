# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="glew-cmake"
PKG_VERSION="36ec731e27e040bd7b5d4a6a4e1bffea75520128" #2.2.0 RC2
PKG_SHA256="756d207712263f33f9a719998bd60dc829e17f48431a53fec6f75a58d6e4f931"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/Perlmint/glew-cmake"
PKG_URL="https://github.com/Perlmint/glew-cmake/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libXi"
PKG_LONGDESC="The OpenGL Extension Wrangler Library (GLEW) is a cross-platform open-source C/C++ extension loading library."

PKG_CMAKE_OPTS_TARGET="-D glew-cmake_BUILD_STATIC=off \
                       -D glew-cmake_BUILD_MULTI_CONTEXT=off \
                       -D PKG_CONFIG_REPRESENTATIVE_TARGET="libglew_shared""
