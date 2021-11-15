#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

. /etc/profile

# Stop Kodi service / load audio backend config
kodi-service.sh --stop

# Change refresh rate to 60Hz
set_refresh_rate_60

# Set audio backend to PulseAudio or ALSA
set_SDL_audiodriver

/usr/bin/retroarch.start -L /tmp/cores/2048_libretro.so

# Switch back to frontends or start Kodi service / unload audio backend config
pidof emulationstation > /dev/null 2>&1 || kodi-service.sh --start
