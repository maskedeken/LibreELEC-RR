# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lr-fsuae"
PKG_VERSION="6b98f852e00a83ecdcf497c1032882ad7b6efc99"
PKG_SHA256="0beaf41955733f30cf092e7aa7e4f5e07a64c0608783fb7e6c820711c44e4ed9"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-fsuae"
PKG_URL="https://github.com/libretro/libretro-fsuae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc glib libmpeg2 openal-soft zlib"
PKG_LONGDESC="FS-UAE amiga emulator."
PKG_TOOLCHAIN="autotools"

PKG_LIBNAME="fsuae_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

pre_configure_target() {
  # NEON Support
  if target_has_feature neon; then
    PKG_CONFIGURE_OPTS_TARGET="--disable-jit \
                               --enable-neon"
  fi
  # Fix cross compiling
  export ac_cv_func_realloc_0_nonnull=yes
  cd ${PKG_BUILD}
}

make_target() {
  if [ ${ARCH} = "arm" ]; then
    make gen -j4 CC="${HOST_CC}" CPPFLAGS="${HOST_CPPFLAGS}" CFLAGS="${HOST_CFLAGS}" LDFLAGS="${HOST_LDFLAGS}"
  else
    make gen -j4 CC="${CC}"
  fi
  make clean
  make CC="${CC}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/fs-uae
  cp -v fs-uae.dat ${INSTALL}/usr/share/fs-uae/

  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
