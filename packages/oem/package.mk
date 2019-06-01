# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Frank Hartung (supervisedthinking@gmail.com)

PKG_NAME="oem"
PKG_VERSION="1.0"
PKG_LICENSE="various"
PKG_SITE="http://www.libreelec.tv"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="oem"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"
PKG_TOOLCHAIN="manual"

# Common tools included in all images
OEM_TOOLS_COMMON=" \
  rr-config-tool \
  ds4drv \
  htop \
  lm-sensors \
  midnight-commander \
  sdl-jstest \
  Skyscraper \
  spectre-meltdown-checker"

# Specific tools included in Amlogic images
OEM_TOOLS_AMLOGIC=""

# Specific tools included in Generic images
OEM_TOOLS_GENERIC=" \
  dmidecode \
  google-chrome \
  mesa-demos-system \
  moonlight-qt \
  smartmontools \
  spotify \
  tigervnc-system \
  vulkan-tools"

# Specific tools included in Rockchip images
OEM_TOOLS_ROCKCHIP=""

# Specific tools included in RPi images
OEM_TOOLS_RPI=""

# Common emulators included in all images
OEM_EMULATORS_COMMON=" \
  emulationstation \
  pegasus-frontend \
  retroarch \
  dosbox-sdl2 \
  hatari \
  moonlight-embedded \
  ppsspp \
  lr-2048 \
  lr-atari800 \
  lr-beetle-dc \
  lr-beetle-pce-fast \
  lr-beetle-wswan \
  lr-bluemsx \
  lr-chailove \
  lr-desmume \
  lr-dosbox \
  lr-fbneo \
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
  lr-scummvm \
  lr-snes9x \
  lr-stella2014 \
  lr-tyrquake"

# Specific emulators included in Amlogic images
OEM_EMULATORS_AMLOGIC=" \
  amiberry \
  lr-mame2010 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause"

# Specific emulators included in Generic images
OEM_EMULATORS_GENERIC=" \
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
  lr-ppsspp \
  lr-yabasanshiro"

# Specific emulators included in Rockchip images
OEM_EMULATORS_ROCKCHIP=" \
  amiberry \
  lr-mame2016 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause \
  lr-yabasanshiro"

# Specific emulators included in RPi images
OEM_EMULATORS_RPI=" \
  amiberry \
  lr-mame2010 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause"

# Install common & specific tools
if [ "${OEM_TOOLS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_COMMON}"
  case ${PROJECT} in
    Amlogic)
      PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_AMLOGIC}"
      ;;
    Generic)
      PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_GENERIC}"
      ;;
    Rockchip)
      PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_ROCKCHIP}"
      ;;
    RPi*)
      PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_RPI}"
      ;;
  esac
fi

# Install common & specific emulators
if [ "${OEM_EMULATORS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_COMMON}"
  case ${PROJECT} in
    Amlogic)
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_AMLOGIC}"
      ;;
    Generic)
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_GENERIC}"
      ;;
    Rockchip)
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_ROCKCHIP}"
      ;;
    RPi*)
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_RPI}"
      ;;
  esac
fi

makeinstall_target() {
  # Create dirs
  mkdir -p ${INSTALL}

  # Copy oem config files & scripts
  cp -PRv ${PKG_DIR}/files/common/*     ${INSTALL}
  cp -PRv ${PKG_DIR}/files/${PROJECT}/* ${INSTALL}
}
