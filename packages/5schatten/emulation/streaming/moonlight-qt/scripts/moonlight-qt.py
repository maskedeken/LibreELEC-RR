#!/usr/bin/python
import subprocess
subprocess.call("systemd-run /usr/bin/moonlight-qt.start", shell=True)
