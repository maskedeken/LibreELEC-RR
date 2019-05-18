#!/usr/bin/python
import subprocess
subprocess.call("systemd-run /usr/bin/pegasus-fe.start", shell=True)
