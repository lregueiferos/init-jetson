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
      # 2. Install Torch 2.3.0 (Direct link for CUDA 12.6 / JP 6.1)
# 1. Base PyTorch 2.3.0 (This usually works, but here is the official NVIDIA link)
pip3 install https://developer.download.nvidia.com/compute/redist/jp/v60/pytorch/torch-2.3.0a0+ebedce2.nv24.03-cp310-cp310-linux_aarch64.whl

# 2. TorchVision 0.18.0 (Corrected link)
pip3 install https://developer.download.nvidia.com/compute/redist/jp/v60/pytorch/torchvision-0.18.0a0+6043bc2.nv24.03-cp310-cp310-linux_aarch64.whl

# 3. TorchAudio 2.3.0 (Corrected link)
pip3 install https://developer.download.nvidia.com/compute/redist/jp/v60/pytorch/torchaudio-2.3.0+952ea74.nv24.03-cp310-cp310-linux_aarch64.whl
    fi
    #install aditional requrements
    reboot

