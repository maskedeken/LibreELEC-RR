# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="glew-cmake"
PKG_VERSION="6f770a5b5b9a904972b9c6974e40106bc3a27b5a" #2.2.0 RC2
PKG_SHA256="2e4bc128bc8fe0cfacf7dcb466fe101083f9901f80b731415a5318bf76e7f789"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/Perlmint/glew-cmake"
PKG_URL="https://github.com/Perlmint/glew-cmake/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libXi glu"
PKG_LONGDESC="The OpenGL Extension Wrangler Library (GLEW) is a cross-platform open-source C/C++ extension loading library."

PKG_CMAKE_OPTS_TARGET="-D glew-cmake_BUILD_STATIC=off \
                       -D glew-cmake_BUILD_MULTI_CONTEXT=off \
                       -D USE_GLU=ON \
                       -D PKG_CONFIG_REPRESENTATIVE_TARGET="libglew_shared""
