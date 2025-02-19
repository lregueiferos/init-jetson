sudo apt-get install xorg
sudo apt install xterm
cd Desktop/Dashboard/build/linux/*/release/bundle
xinit ./rover_control_dahsboard $* -- :0 vt$XDG_VTNR