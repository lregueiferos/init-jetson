#!/bin/sh
cd /etc/systemd/system
file="Rover-INIT.Service"
echo "Adding first line" > $file
echo "[Unit]" > $file
echo "Description=Reboot message systemd service. " >> $file
echo "" >> $file
echo "[Service]" >> $file
echo "Type=simple" >> $file
echo "ExecStart=/bin/bash /home/init-jetson/Xinit.sh" >> $file
echo "" >> $file
echo "[Install]" >> $file
echo "WantedBy=multi-user.target" >> $file
cat $file
chmod 644 Rover-INIT.Service
systemctl Rover-INIT.Service
cd
cd Desktop/Dashboard/build/linux/
cd */release/bundle
xinit ./rover_control_dahsboard $* -- :0 vt$XDG_VTNR