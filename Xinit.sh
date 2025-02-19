#!/bin/sh
cd
cd Desktop/Dashboard/build/linux/
cd */release/bundle
xinit ./rover_control_dahsboard $* -- :0 vt$XDG_VTNR
