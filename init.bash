sudo apt update
sudo apt upgrade -y
sudo apt-get install curl
cd
cd Desktop
git clone https://github.com/BinghamtonRover/Dashboard
git clone https://github.com/BinghamtonRover/Rover-Code
cd
cd Downloads
git clone https://github.com/NaiveInvestigator/flutter-installer
cd flutter-installer
bash install.sh
cd
sudo apt-get install libasound2-dev
mv Rover-init.Service /etc/systemd/system/Rover-init.service
reboot
