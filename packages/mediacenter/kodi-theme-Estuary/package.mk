# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="kodi-theme-Estuary"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi"
PKG_NEED_UNPACK="$(get_pkg_directory $MEDIACENTER)"
PKG_LONGDESC="Kodi Mediacenter default theme."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -a $(get_build_dir kodi)/.$TARGET_NAME/addons/skin.estuary $INSTALL/usr/share/kodi/addons/

  # Add Chrome & Spotify shortcuts to menu
  if [ ! "${OEM_APPS}" = "no" ] && [ "${PROJECT}" = "Generic" ]; then
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.estuary -p1 < ${PKG_DIR}/files/kodi-theme-Estuary-100.01-app-menu.patch
  fi

  # Add Emulationstation, Moonlight, Pegasus & Retroarch shortcuts to menu
  if [ ! "${OEM_EMU}" = "no" ]; then
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.estuary -p1 < ${PKG_DIR}/files/kodi-theme-Estuary-100.02-emulation-menu.patch
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.estuary -p1 < ${PKG_DIR}/files/kodi-theme-Estuary-100.03-moonlight-qt-menu.patch
  fi
}
