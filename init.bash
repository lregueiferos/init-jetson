set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo" 
   exit 1
fi
    #updates the system
    sudo apt update > /dev/null 2>&1
    sudo apt upgrade -y > /dev/null 2>&1
    sudo apt-get install curl busybox nano libasound2-dev can-utils
    cd /home/rover

    #clones the rover code to the Desktop
    git clone https://github.com/flutter/flutter -b stable
    export PATH="$PATH:/home/rover/flutter/bin"
    flutter doctor
    git clone --recursive https://github.com/BinghamtonRover/Dashboard
    git clone --recursive https://github.com/BinghamtonRover/Rover-Code
    sudo mv /home/rover/init-jetson/rc.local /etc/

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
    if [[cuda == Y]]; then
        cd /home/rover/Downloads
        sudo apt-get update
        sudo apt-get install -y libopenblas-base libopenmpi-dev libomp-dev libjpeg-dev zlib1g-dev
        wget https://nvidia.box.com/shared/static/mp634pt2xcl9697btze69sh32o9968is.whl -O torch-2.3.0-cp310-cp310-linux_aarch64.whl
        pip3 install torch-2.3.0-cp310-cp310-linux_aarch64.whl
        pip3 install torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl
        pip3 install torchaudio-2.3.0+952ea74-cp310-cp310-linux_aarch64.whl
    fi
    #install aditional requrements
    reboot

