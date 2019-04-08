# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="oem"
PKG_VERSION="1.0"
PKG_LICENSE="various"
PKG_SITE="http://www.libreelec.tv"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="oem"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"

PKG_TOOLCHAIN="manual"

OEM_APPS_COMMON=" \
  rr-config-tool \
  ds4drv \
  htop \
  lm-sensors \
  midnight-commander \
  sdl-jstest \
  Skyscraper \
  spectre-meltdown-checker"

OEM_APPS_AMLOGIC=""

OEM_APPS_GENERIC=" \
  dmidecode \
  google-chrome \
  mesa-demos-system \
  smartmontools \
  spotify \
  tigervnc-system \
  vulkan-tools"

OEM_APPS_RPI=""

OEM_EMU_COMMON=" \
  emulationstation \
  pegasus-frontend \
  retroarch \
  dosbox-sdl2 \
  hatari \
  moonlight-embedded \
  ppsspp \
  lr-2048 \
  lr-atari800 \
  lr-beetle-pce-fast \
  lr-beetle-wswan \
  lr-bluemsx \
  lr-chailove \
  lr-desmume \
  lr-dosbox \
  lr-fbalpha \
  lr-fceumm \
  lr-fuse \
  lr-gambatte \
  lr-genplus \
  lr-mame2003-plus \
  lr-mgba \
  lr-mrboom \
  lr-mupen64plus \
  lr-mupen64plus-nx \
  lr-nestopia \
  lr-pcsx-rearmed \
  lr-prboom \
  lr-reicast \
  lr-scummvm \
  lr-snes9x \
  lr-stella \
  lr-tyrquake"

OEM_EMU_AMLOGIC=" \
  amiberry \
  lr-mame2010 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause"

OEM_EMU_GENERIC=" \
  citra \
  dolphin \
  fs-uae \
  m64p \
  PCSX2 \
  vice \
  yquake2 \
  lr-beetle-psx \
  lr-beetle-saturn \
  lr-bsnes-mercury-accuracy \
  lr-bsnes-mercury-balanced \
  lr-citra \
  lr-dolphin \
  lr-kronos \
  lr-mame2016 \
  lr-mesen \
  lr-nSide \
  lr-parallel-n64 \
  lr-ppsspp"

OEM_EMU_RPI=" \
  amiberry \
  lr-mame2010 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause"

if [ "$OEM_APPS" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_COMMON"
  case $PROJECT in
    Amlogic_Legacy)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_AMLOGIC"
      ;;
    Generic)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_GENERIC"
      ;;
    RPi*)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_RPI"
      ;;
  esac
fi

if [ "$OEM_EMU" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_COMMON"
  case $PROJECT in
    Amlogic_Legacy)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_AMLOGIC"
      ;;
    Generic)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_GENERIC"
      ;;
    RPi*)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_RPI"
      ;;
  esac
fi

makeinstall_target() {
  # Create dirs
  mkdir -p $INSTALL

  # Copy oem config files & scripts
  cp -PR $PKG_DIR/files/common/*   $INSTALL
  cp -PR $PKG_DIR/files/$PROJECT/* $INSTALL
}
