set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
echo "this script will take up to 3 hours are you sure you want to run this now"
read -p "Y/N " response
if [[response == "N"]]
    exit
fi 


#checks the number of phisical cpu cores on the system
if [[ $(nproc) -eq 6]]; then

    #updates the system
    sudo apt update
    sudo apt upgrade -y
    sudo apt-get install curl
    cd
    cd Desktop

    #clones the rover code to the Desktop
    git clone https://github.com/BinghamtonRover/Dashboard
    git clone https://github.com/BinghamtonRover/Rover-Code
    cd
    cd Downloads

    #installs fultter usingthe flutter-installer repo
    git clone https://github.com/NaiveInvestigator/flutter-installer
    cd flutter-installer
    bash install.sh
    cd

    echo "# Enabling automatic login
    AutomaticLoginEnable = true
    AutomaticLogin = user1

    # Enabling timed login
    TimedLoginEnable = true
    TimedLogin = user1
    TimedLoginDelay = 10" >> /etc/gdm3/custom.conf
    sudo systemctl set-default multi-user.target
    #installs opencv with cuda support
    git clone https://github.com/AastaNV/JEP
    cd JEP/script
    sudo bash install_opencv4.10.0_Jetpack6.1.sh

    #install aditional requrements and adds the rover-init service to systemd
    sudo apt-get install libasound2-dev
    mv Rover-init.Service /etc/systemd/system/Rover-init.service
    flutter doctor
    reboot

# runs the pi setup if the number of cores is not 6 as the jetson has 6 cpu cores and the pi has 4
# if future pi's have 6 cores instead evaluate the system based off of the userid
else 
    sudo apt update
    sudo apt upgrade -y
    sudo apt install curl
    cd Desktop
    git clone https://github.com/BinghamtonRover/Dashboard
    git clone https://github.com/BinghamtonRover/Rover-Code
    cd
    cd Downloads
    git clone https://github.com/NaiveInvestigator/flutter-installer
    cd flutter-installer
    bash install.sh
    sudo rm -rf flutter-installer
    cd
    flutter doctor

    # downlaods flutter pi and flutterpi-tool
    sudo apt install cmake libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev ttf-mscorefonts-installer fontconfig libsystemd-dev libinput-dev libudev-dev  libxkbcommon-dev
    sudo fc-cache
    git clone --recursive https://github.com/ardera/flutter-pi
    cd flutter-pi
    mkdir build && cd build
    cmake ..
    make -j`nproc`
    sudo make install
    flutter pub global activate flutterpi_tool
    reboot