# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="SDL_GameControllerDB"
PKG_VERSION="cbebd79740bc1360978bdf6d9d4d13d189e420a3"
PKG_SHA256="a1274ed0acf6cf4c8596d1a55a240db686d86ee346d896fdb8bc8c10c2a27415"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/gabomdq/SDL_GameControllerDB"
PKG_URL="https://github.com/gabomdq/SDL_GameControllerDB/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_LONGDESC="A community sourced database of game controller mappings to be used with SDL2 Game Controller functionality"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/SDL-GameControllerDB
  cp ${PKG_BUILD}/gamecontrollerdb.txt ${INSTALL}/usr/config/SDL-GameControllerDB
}
