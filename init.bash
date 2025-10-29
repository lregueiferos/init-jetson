set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi


#checks the number of phisical cpu cores on the system


    #updates the system
    sudo apt update
    sudo apt upgrade -y
    sudo apt-get install curl
    cd /home/rover/Desktop

    #clones the rover code to the Desktop
    git clone https://github.com/BinghamtonRover/Dashboard
    git clone https://github.com/BinghamtonRover/Rover-Code
    cd /home/rover/Downloads

    #installs fultter usingthe flutter-installer repo
    git clone https://github.com/NaiveInvestigator/flutter-installer
    cd /home/rover/Downloads/flutter-installer
    bash install.sh

    echo "# Enabling automatic login
    AutomaticLoginEnable = true
    AutomaticLogin = user1

    # Enabling timed login
    TimedLoginEnable = true
    TimedLogin = rover
    TimedLoginDelay = 10" >> /etc/gdm3/custom.conf
    sudo systemctl set-default multi-user.target
    #installs opencv with cuda support
    echo "do you want to compile opencv with cuda"
    read -p "Y/N" cuda
    if [[cuda == Y]]
        wget https://nvidia.box.com/shared/static/9si945yrzesspmg9up4ys380lqxjylc3.whl -O torchaudio-2.3.0+952ea74-cp310-cp310-linux_aarch64.whl
        pip3 install torchaudio-2.3.0+952ea74-cp310-cp310-linux_aarch64.whl
        wget https://nvidia.box.com/shared/static/u0ziu01c0kyji4zz3gxam79181nebylf.whl -O torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl
        pip3 install torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl
        pip3 install torch==2.3
    fi
    #install aditional requrements
    sudo apt-get install libasound2-dev
    flutter doctor
    reboot

