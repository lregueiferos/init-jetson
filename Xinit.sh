#!/bin/sh
cd
cd Desktop/Dashboard/build/linux/
cd */release/bundle
mv Rover-init.Service /etc/systemd/system/Rover-init.service
xinit ./rover_control_dahsboard $* -- :0 vt$XDG_VTNR
