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
