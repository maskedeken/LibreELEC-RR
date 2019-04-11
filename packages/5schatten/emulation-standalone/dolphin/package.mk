# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="dolphin"
PKG_VERSION="d5ed3cbd88b9cd473b4de5fbbf576ab18db2ab37"
PKG_SHA256="230d99f2f1889b484a5cd0e1c83088cc43dc5a4b08d5c4a1a31c13b50a6ddc50"
PKG_DOLPHIN_RELEASE="5.0-9950"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/dolphin-emu/dolphin"
PKG_URL="https://github.com/dolphin-emu/${PKG_NAME}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc systemd openal-soft libevdev curl ffmpeg libpng zlib bzip2 bluez pulseaudio alsa-lib libogg libvorbis libSM enet qt-everywhere"
PKG_LONGDESC="Dolphin is a GameCube / Wii emulator, allowing you to play games for these two platforms on PC with improvements."

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DENABLE_LTO=off \
                         -DUSE_SHARED_ENET=on \
                         -DUSE_DISCORD_PRESENCE=off \
                         -DENABLE_ANALYTICS=off \
                         -DDISTRIBUTOR=5schatten"
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
  
  # Export QT path
  export Qt5Gui_DIR=${SYSROOT_PREFIX}/usr/lib

  # Export Dolphin revision
  PKG_DOLPHIN_BRANCH="Master"
  PKG_DOLPHIN_DISTRI="5schatten"
  PKG_DOLPHIN_REV_H=Source/Core/Common/scmrev.h

  echo "#define SCM_REV_STR" ""\"${PKG_VERSION}""\"                >  ${PKG_DOLPHIN_REV_H}
  echo "#define SCM_DESC_STR" ""\"${PKG_DOLPHIN_RELEASE}""\"       >> ${PKG_DOLPHIN_REV_H}
  echo "#define SCM_BRANCH_STR" ""\"$PKG_DOLPHIN_BRANCH""\"        >> ${PKG_DOLPHIN_REV_H}
  echo "#define SCM_IS_MASTER 0"                                   >> ${PKG_DOLPHIN_REV_H}
  echo "#define SCM_DISTRIBUTOR_STR" ""\"${PKG_DOLPHIN_DISTRI}""\" >> ${PKG_DOLPHIN_REV_H}
  echo "#define SCM_UPDATE_TRACK_STR" ""\"\"                       >> ${PKG_DOLPHIN_REV_H}
}

post_makeinstall_target() {
  # Copy scripts & config files
  mkdir -p ${INSTALL}/usr/config/dolphin-emu
  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/
  cp -PR ${PKG_DIR}/config/* ${INSTALL}/usr/config/dolphin-emu/

  # Clean up
  rm ${INSTALL}/usr/bin/dolphin-emu-nogui
  rm -rf ${INSTALL}/usr/share/applications
  rm -rf ${INSTALL}/usr/share/icons
}
