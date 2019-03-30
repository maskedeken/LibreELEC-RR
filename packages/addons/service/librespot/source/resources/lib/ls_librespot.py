# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import subprocess
import time
import xbmcaddon

from ls_env import LS_SINK as LS_SINK
from ls_log import log as log


_SERVICE = xbmcaddon.Addon().getAddonInfo('id')


def _systemctl(command):
    log('systemctl {}'.format(command))
    return subprocess.call(['systemctl', command, _SERVICE])


class Librespot():

    def __init__(self):
        while (_systemctl('is-enabled') != 0):
          time.sleep(1)
        self.state = (_systemctl('is-active') == 0)

    def start(self):
        if not self.state:
            log('starting librespot')
            _systemctl('start')
            self.state = True

    def stop(self):
        if self.state:
            log('stopping librespot')
            _systemctl('stop')
            self.state = False

    def unsuspend(self):
        subprocess.call(['pactl', 'suspend-sink', LS_SINK, '0'])
