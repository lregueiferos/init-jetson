#!/bin/sh
export DISPLAY=:0
export XDG_SESSION_TYPE=x11
cd
cd Desktop/Dashboard/build/linux
cd *
cd release/bundle
xinit ./rover_control_dashboard $* -- :0 vt$vt1
