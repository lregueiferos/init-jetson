#!/bin/sh

export DISPLAY=:0
export XDG_SESSION_TYPE=x11

cd ~/Desktop/Dashboard/build/linux
cd *
cd release/bundle || exit

# Ensure X server is running before launching
while ! pgrep Xorg > /dev/null; do
    echo "Waiting for X server to start..."
    sleep 2
done

xinit ./rover_control_dashboard -- :0 vt1
