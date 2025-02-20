#!/bin/sh

export DISPLAY=:0
export XDG_SESSION_TYPE=x11

cd ~/Desktop/Dashboard/build/linux
cd *
cd release/bundle || exit


xinit ./rover_control_dashboard -- :0 vt1
