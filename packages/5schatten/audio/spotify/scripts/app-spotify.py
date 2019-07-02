#!/usr/bin/python
import subprocess
subprocess.call("systemd-run /usr/bin/spotify.start", shell=True)
