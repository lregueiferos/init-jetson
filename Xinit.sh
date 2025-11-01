#!/bin/bash
### BEGIN INIT INFO
# Provides:          rover_control_dashboard
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts the Rover Control Dashboard
# Description:       Initializes the Rover Control Dashboard with X session.
### END INIT INFO

# Run as the rover user (the systemd unit will set the user). This script
# locates the build bundle, sets minimal environment, and launches X with the
# dashboard as the client. Uses dbus-launch so GUI frameworks that expect a
# session bus work correctly.

set -e

export DISPLAY=:0
export XDG_SESSION_TYPE=x11
export HOME=/home/rover
export XAUTHORITY="$HOME/.Xauthority"

# If the Xauthority file doesn't exist yet, don't force it — let xinit
# create it as the session starts. Some systems won't have .Xauthority until
# a session is created, and setting XAUTHORITY to a missing file can cause
# permission or connection problems. Only export it if it exists.
if [ ! -f "$XAUTHORITY" ]; then
	unset XAUTHORITY
fi

# Find the dashboard bundle directory (first match)
bundle_dir=$(ls -d "$HOME"//Dashboard/build/linux/*/release/bundle 2>/dev/null | head -n1 || true)
if [ -z "$bundle_dir" ]; then
	echo "Dashboard bundle not found in $HOME/Dashboard/build/linux/*/release/bundle" >&2
	exit 1
fi

cd "$bundle_dir" || exit 1

# Ensure the binary is executable
if [ ! -x ./rover_control_dashboard ]; then
	chmod +x ./rover_control_dashboard 2>/dev/null || true
fi

# Start a DBus session and run X with the dashboard client. Use -nolisten tcp
# and bind to VT1. If X is already running on :0 this will fail - the service
# should be disabled in that case to avoid conflicts.
exec /usr/bin/dbus-launch --exit-with-session /usr/bin/xinit ./rover_control_dashboard -- :0 vt1 -nolisten tcp
