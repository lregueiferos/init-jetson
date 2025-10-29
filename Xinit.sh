#!/bin/sh
### BEGIN INIT INFO
# Provides:          rover_control_dashboard
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts the Rover Control Dashboard
# Description:       Initializes the Rover Control Dashboard with X session.
### END INIT INFO

export DISPLAY=:0
export XDG_SESSION_TYPE=x11

cd /home/rover/Desktop/Dashboard/build/linux/*/release/bundle || exit

exec xinit ./rover_control_dashboard -- :0 vt1
