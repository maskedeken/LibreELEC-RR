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

################################################################################
# Setup LibreELEC-RR applications
################################################################################

# Specific applications included in Amlogic images
OEM_APPLICATIONS_AMLOGIC=""

# Common applications included in all images
OEM_APPLICATIONS_COMMON=""

# Specific applications included in Generic images
OEM_APPLICATIONS_GENERIC=" \
  google-chrome \
  moonlight-qt \
  spotify"

# Specific applications included in Rockchip images
OEM_APPLICATIONS_ROCKCHIP=""

# Specific applications included in RPi images
OEM_APPLICATIONS_RPI=""

################################################################################
# Setup LibreELEC-RR standalone emulators
################################################################################

# Specific standalone emulators included in Amlogic images
OEM_EMULATORS_AMLOGIC=" \
  amiberry"

# Common standalone emulators included in all images
OEM_EMULATORS_COMMON=" \
  emulationstation \
  dosbox-sdl2 \
  hatari \
  moonlight-embedded \
  ppsspp"

# Specific standalone emulators included in Generic images
OEM_EMULATORS_GENERIC=" \
  citra \
  dolphin \
  fs-uae \
  m64p \
  PCSX2 \
  vice \
  yquake2"

# Specific standalone emulators included in Rockchip images
OEM_EMULATORS_ROCKCHIP=" \
  amiberry"

# Specific standalone emulators included in RPi images
OEM_EMULATORS_RPI=" \
  amiberry"

################################################################################
# Setup LibreELEC-RR additional frontends
################################################################################

# Specific frontends included in Amlogic images
OEM_FRONTENDS_EXTRA_AMLOGIC=""

# Common frontends included in all images
OEM_FRONTENDS_EXTRA_COMMON=" \
  pegasus-frontend"

# Specific frontends included in Generic images
OEM_FRONTENDS_EXTRA_GENERIC=""

# Specific frontends included in Rockchip images
OEM_FRONTENDS_EXTRA_ROCKCHIP=""

# Specific frontends included in RPi images
OEM_FRONTENDS_EXTRA_RPI=""

################################################################################
# Setup LibreELEC-RR libretro cores
################################################################################

# Specific libretro cores included in Amlogic images
OEM_LIBRETRO_AMLOGIC=" \
  lr-mame2010 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause"

# Common libretro cores included in all images
OEM_LIBRETRO_COMMON=" \
  retroarch \
  lr-2048 \
  lr-atari800 \
  lr-beetle-pce-fast \
  lr-beetle-wswan \
  lr-bluemsx \
  lr-chailove \
  lr-desmume \
  lr-dosbox \
  lr-fbneo \
  lr-fceumm \
  lr-flycast \
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

# Specific libretro cores included in Generic images
OEM_LIBRETRO_GENERIC=" \
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

# Specific libretro cores included in Rockchip images
OEM_LIBRETRO_ROCKCHIP=" \
  lr-mame2016 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause \
  lr-yabasanshiro"

# Specific libretro cores included in RPi images
OEM_LIBRETRO_RPI=" \
  lr-mame2010 \
  lr-snes9x2010 \
  lr-vice \
  lr-yabause"

################################################################################
# Setup LibreELEC-RR tools
################################################################################

# Specific tools included in Amlogic images
OEM_TOOLS_AMLOGIC=""

# Common tools included in all images
OEM_TOOLS_COMMON=" \
  ds4drv \
  htop \
  lm-sensors \
  midnight-commander \
  rr-config-tool \
  sdl-jstest \
  Skyscraper \
  spectre-meltdown-checker \
  strace-system"

# Specific tools included in Generic images
OEM_TOOLS_GENERIC=" \
  dmidecode \
  mesa-demos-system \
  smartmontools \
  tigervnc-system \
  vulkan-tools"

# Specific tools included in Rockchip images
OEM_TOOLS_ROCKCHIP=""

# Specific tools included in RPi images
OEM_TOOLS_RPI=""

################################################################################
# Install OEM packages to LibreELEC-RR
################################################################################

configure_package() {
  if [ "${OEM_SUPPORT}" = "yes" ]; then

    # Add application packages
    if [ "${OEM_APPLICATIONS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_APPLICATIONS_COMMON}"
      case ${PROJECT} in
        Amlogic)
          PKG_DEPENDS_TARGET+=" ${OEM_APPLICATIONS_AMLOGIC}"
          ;;
        Generic)
          PKG_DEPENDS_TARGET+=" ${OEM_APPLICATIONS_GENERIC}"
          ;;
        Rockchip)
          PKG_DEPENDS_TARGET+=" ${OEM_APPLICATIONS_ROCKCHIP}"
          ;;
        RPi)
          PKG_DEPENDS_TARGET+=" ${OEM_APPLICATIONS_RPI}"
          ;;
      esac
    fi

    # Add emulator packages
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
        RPi)
          PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_RPI}"
          ;;
      esac
    fi

    # Add frontend packages
    if [ "${OEM_FRONTENDS_EXTRA}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_FRONTENDS_EXTRA_COMMON}"
      case ${PROJECT} in
        Amlogic)
          PKG_DEPENDS_TARGET+=" ${OEM_FRONTENDS_EXTRA_AMLOGIC}"
          ;;
        Generic)
          PKG_DEPENDS_TARGET+=" ${OEM_FRONTENDS_EXTRA_GENERIC}"
          ;;
        Rockchip)
          PKG_DEPENDS_TARGET+=" ${OEM_FRONTENDS_EXTRA_ROCKCHIP}"
          ;;
        RPi)
          PKG_DEPENDS_TARGET+=" ${OEM_FRONTENDS_EXTRA_RPI}"
          ;;
      esac
    fi

    # Add libretro packages
    if [ "${OEM_LIBRETRO}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_LIBRETRO_COMMON}"
      case ${PROJECT} in
        Amlogic)
          PKG_DEPENDS_TARGET+=" ${OEM_LIBRETRO_AMLOGIC}"
          ;;
        Generic)
          PKG_DEPENDS_TARGET+=" ${OEM_LIBRETRO_GENERIC}"
          ;;
        Rockchip)
          PKG_DEPENDS_TARGET+=" ${OEM_LIBRETRO_ROCKCHIP}"
          ;;
        RPi)
          PKG_DEPENDS_TARGET+=" ${OEM_LIBRETRO_RPI}"
          ;;
      esac
    fi

    # Add tool packages
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
        RPi)
          PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_RPI}"
          ;;
      esac
    fi
  fi
}

makeinstall_target() {
  # Create directories
  mkdir -p ${INSTALL}

  # Install OEM config files & scripts
  cp -PRv ${PKG_DIR}/files/common/*     ${INSTALL}
  cp -PRv ${PKG_DIR}/files/${PROJECT}/* ${INSTALL}
}
