#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (at) gmail.com)

# Source environment variables
. /etc/profile
oe_setup_addon service.rr-config-tool

# Set common variables
RR_FLUIDSYNTH_SERVICE_STATE=$(systemctl status fluidsynth | grep 'Active:' | awk '{print $2}')
RR_KODI_MUTE_STATE=/var/run/kodi-service-muted
RR_KODI_SERVICE_STATE=$(systemctl status kodi | grep 'Active:' | awk '{print $2}')
RR_USLEEP_DELAY=500000

# Set functions
kodi_cleanup_mute_state() {
  if [ -f "${RR_KODI_MUTE_STATE}" ]; then
    rm "${RR_KODI_MUTE_STATE}"
  fi
}

kodi_service_mute() {
  kodi-send --action="RunScript(/usr/bin/kodi-service-mute.py)" > /dev/null
  echo "Muting Kodi service."
  touch ${RR_KODI_MUTE_STATE}
}

kodi_service_unmute() {
  kodi-send --action="RunScript(/usr/bin/kodi-service-unmute.py)" > /dev/null
  echo "Unmuting Kodi service."
  kodi_cleanup_mute_state
}

kodi_service_start() {
  kodi_cleanup_mute_state
  if [ ! "${RR_FLUIDSYNTH_SERVICE_STATE}" = "active" ]; then
    echo "Starting Kodi service."
    usleep "${RR_USLEEP_DELAY}"
    systemctl start kodi
  else
    if [ "${RR_AUDIO_BACKEND}" = "PulseAudio" ];then
      echo "Stopping FluidSynth service, unloading PulseAudio sinks & start Kodi service."
    else
      echo "Starting Kodi service."
    fi
    stop_FluidSynth_backend
    usleep "${RR_USLEEP_DELAY}"
    unload_pulseaudio_sink
    wait $(pidof pactl)
    usleep "${RR_USLEEP_DELAY}"
    systemctl start kodi
  fi
}

kodi_service_stop() {
  kodi_cleanup_mute_state
  if [ "${1}" = "forceALSA" ]; then
    echo "Stopping Kodi service & force using ALSA backend."
    systemctl stop kodi
    wait $(pidof kodi.bin)
  else
    if [ ${RR_AUDIO_BACKEND} = "PulseAudio" ];then
      echo "Stopping Kodi service, load PulseAudio sinks & start FluidSynth service."
    else
      echo "Stopping Kodi service."
    fi
    systemctl stop kodi
    wait $(pidof kodi.bin)
    usleep "${RR_USLEEP_DELAY}"
    load_pulseaudio_sink
    usleep "${RR_USLEEP_DELAY}"
    start_FluidSynth_backend
  fi
}

# Command line interface
case ${1} in
  --mute)
    if [ "${RR_KODI_SERVICE_STATE}" = "active" ] && [ ! -f "${RR_KODI_MUTE_STATE}" ]; then
      kodi_service_mute
    else
      echo "Kodi service was already muted or isn't running."
    fi
    ;;
  --unmute)
    if [ "${RR_KODI_SERVICE_STATE}" = "active" ] && [ -f "${RR_KODI_MUTE_STATE}" ]; then
      kodi_service_unmute
    else
      echo "Kodi service was not muted or isn't running."
    fi
    ;;
  --start)
    if [ ! "${RR_KODI_SERVICE_STATE}" = "active" ]; then
      kodi_service_start
    else
      echo "Kodi service is already running."
    fi
    ;;
  --stop)
    if [ "${RR_KODI_SERVICE_STATE}" = "active" ]; then
      kodi_service_stop ${2}
    else
      echo "Kodi service is already stopped."
    fi
    ;;
  *)
    echo "Usage:" 
    echo -e "  ${0} --[mute|unmute|start|stop] [forceALSA]\n"
    echo "Kodi service options:"
    echo "  --mute           - mutes   Kodi audio & stopps video player"
    echo "  --unmute         - unmutes Kodi audio"
    echo "  --start          - starts  Kodi service"
    echo "  --stop           - stops   Kodi service & starts audio services depending on configured backend"
    echo "  --stop forceALSA - stops   Kodi service & forces ALSA audio"
    ;;
esac
