#!/bin/sh
cd
cd Desktop/Dashboard/build/linux
cd *
cd release/bundle
xinit ./rover_control_dashboard $* -- :0 vt$XDG_VTNR
