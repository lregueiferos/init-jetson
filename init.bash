sudo apt update
sudo apt upgrade -y
cd
cd Desktop
mkdir Dashbaord
mkdir Rover-Code
cd Dashbaord
git clone https://github.com/BinghamtonRover/Dashboard
cd ..
cd Rover-Code
git clone https://github.com/BinghamtonRover/Rover-Code
cd
cd Downloads
git clone https://github.com/NaiveInvestigator/flutter-installer
cd flutter-installer
bash install.sh
cd
sudo apt-get install libasound2-dev
reboot
