# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

import json
import subprocess
import xbmc
import xbmcaddon
import xbmcgui

class Monitor(xbmc.Monitor):

    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)
        self.id = xbmcaddon.Addon().getAddonInfo('id')

    def onSettingsChanged(self):
        subprocess.call(['systemctl', 'restart', self.id])


if __name__ == '__main__':
    if not 'ALSA: Snapcast for Kodi' in json.dumps(xbmc.executeJSONRPC(
            '{"jsonrpc":"2.0","method":"Settings.GetSettings",\
            "params":{"level":"expert","filter":{"section":"system",\
            "category":"audio"}},"id":1}')):
        if xbmcgui.Dialog().yesno(
                xbmcaddon.Addon().getAddonInfo('name'),
                xbmcaddon.Addon().getLocalizedString(30010)) == True:
            subprocess.call(['systemctl', 'restart', 'kodi'])
    Monitor().waitForAbort()
