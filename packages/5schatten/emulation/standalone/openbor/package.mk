# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="openbor"
PKG_VERSION="093900a52fb913feabc64cac29229bf865a8a14c"
PKG_SHA256="0aad02e263b566551d7791fbc924c56bbca475b0737b3416453e85f3ee257aec"
PKG_ARCH="any"
PKG_SITE="https://github.com/DCurrent/openbor"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 libogg libvorbis libvpx libpng"
PKG_SHORTDESC="OpenBOR is the ultimate 2D side scrolling engine for beat em' ups, shooters, and more! "
PKG_LONGDESC="OpenBOR is the ultimate 2D side scrolling engine for beat em' ups, shooters, and more! "
PKG_TOOLCHAIN="make"

pre_configure_target() {
  PKG_MAKE_OPTS_TARGET="BUILD_LINUX_${ARCH}=1 \
                        -C ${PKG_BUILD}/engine \
                        SDKPATH="${SYSROOT_PREFIX}"
                        PREFIX=${TARGET_NAME}"

}

pre_make_target() {
  # Generate version.h
  cd ${PKG_BUILD}/engine
  ./version.sh
}

makeinstall_target() {
  # Install binary & start script
  mkdir -p ${INSTALL}/usr/bin
    cp -fv ${PKG_BUILD}/engine/OpenBOR ${INSTALL}/usr/bin/openbor
    cp -rfv ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  # Install default config cfg
  mkdir -p ${INSTALL}/usr/config/openbor
    cp -rfv ${PKG_DIR}/config/* ${INSTALL}/usr/config/openbor
}
