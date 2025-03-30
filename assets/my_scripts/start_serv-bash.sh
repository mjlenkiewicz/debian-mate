#!/bin/bash

# Start services
service dbus start /usr/lib/systemd/systemd-logind >> /dev/null
service xrdp start >> /dev/null
service smbd start >> /dev/null

# Stay in the bash
bash

# Keep the container running (if the "bash" is not needed !!!)
# tail -f /dev/null