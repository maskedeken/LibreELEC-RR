# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import os
import stat
import threading
import xbmc
import xbmcaddon
import xbmcgui

from ls_env import LS_FIFO as LS_FIFO
from ls_env import LS_IP as LS_IP
from ls_env import LS_PORT as LS_PORT
from ls_librespot import Librespot as Librespot
from ls_log import log as log
from ls_spotify import Spotify as Spotify

_CODEC = 'pcm_s16le'
_STREAM = 'rtp://{}:{}'.format(LS_IP, LS_PORT)

_DIALOG = xbmcgui.Dialog()
_LISTITEM = xbmcgui.ListItem()
_LISTITEM.addStreamInfo('audio', {'codec': _CODEC})
_LISTITEM.setPath(_STREAM)


class Player(threading.Thread, xbmc.Player):

    def __init__(self):
        super(Player, self).__init__()
        self.librespot = Librespot()
        self.spotify = Spotify()
        self.updateSettings()
        self.start()

    def isPlayingLibrespot(self):
        return self.isPlaying() and self.getPlayingFile() == _STREAM

    def onAbortRequested(self):
        log('abort requested')
        with open(LS_FIFO, 'w') as fifo:
            fifo.close()
        self.join()

    def onPlayBackEnded(self):
        log('a playback ended')
        self.onStop()

    def onPlayBackError(self):
        log('a playback error')
        self.onStop()

    def onAVChange(self):
        log('a stream changed')
        self.onStart()

    def onAVStarted(self):
        log('a stream started')
        self.onStart()

    def onPlayBackStopped(self):
        log('a playback stopped')
        self.onStop()

    def onSettingsChanged(self):
        log('settings changed')
        self.stop()
        self.librespot.stop()
        self.updateSettings()

    def onStart(self):
        if self.getPlayingFile() != _STREAM:
            self.librespot.stop()

    def onStop(self):
        self.librespot.start()

    def pause(self, track_id):
        if self.isPlayingLibrespot():
            log('pausing librespot playback')
            super(Player, self).pause()
        else:
            self.play(track_id)

    def play(self, track_id):
        track = self.spotify.getTrack(track_id)
        if self.playsWithKodi:
            _LISTITEM.setArt({'thumb': track['thumb']})
            _LISTITEM.setInfo(
                'music',
                {
                    'album': track['album'],
                    'artist': track['artist'],
                    'title': track['title']
                }
            )
            _LISTITEM.setPath(_STREAM)
            log('starting librespot playback')
            if self.isPlayingLibrespot():
                self.updateInfoTag(_LISTITEM)
            else:
                self.librespot.unsuspend()
                super(Player, self).play(_STREAM, _LISTITEM)
        else:
            _DIALOG.notification(
                track['title'],
                track['artist'],
                icon=track['thumb'],
                sound=False)

    def run(self):
        log('named pipe started')
        try:
            os.unlink(LS_FIFO)
        except OSError:
            pass
        os.mkfifo(LS_FIFO)
        while (os.path.exists(LS_FIFO) and
               stat.S_ISFIFO(os.stat(LS_FIFO).st_mode)):
            with open(LS_FIFO, 'r') as fifo:
                command = fifo.read().splitlines()
                log('named pipe received {}'.format(str(command)))
                if len(command) == 0:
                    break
                elif command[0] in ['3', '5', '6']:
                    self.pause(command[1])
                elif command[0] in ['1', '2']:
                    self.play(command[1])
                elif command[0] in ['4', '7']:
                    self.stop()
        try:
            os.unlink(LS_FIFO)
        except OSError:
            pass
        log('named pipe stopped')

    def stop(self):
        if self.isPlayingLibrespot():
            log('stopping librespot playback')
            super(Player, self).stop()

    def updateSettings(self):
        log('updating settings')
        self.playsWithKodi = (xbmcaddon.Addon().getSetting('ls_m') == 'Kodi')
        if self.isPlaying():
            self.onStart()
        else:
            self.onStop()
