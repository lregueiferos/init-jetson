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
        pip3 install --no-cache-dir https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl
       # Force install Vision and Audio for CUDA 12.6
      # 1. Download the code
# 1. Update the keyring to ensure you can reach the NVIDIA repos
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/arm64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update

# 2. Install the missing library and development files
sudo apt-get install -y libcusparselt0 libcusparselt-dev

# 3. Refresh the system's library cache
sudo ldconfig
      
git clone --branch v0.20.0 https://github.com/pytorch/vision torchvision
cd torchvision

# 2. Tell the installer which version we want
export BUILD_VERSION=0.20.0

# 3. Start the build (This will take about 5-10 minutes)
# Use --user to avoid permission issues
python3 setup.py install --user

# 4. Move back to your home directory
cd ..

# 1. Download the code
git clone --branch v2.5.0 https://github.com/pytorch/audio torchaudio
cd torchaudio

# 2. Tell the installer which version we want
export BUILD_VERSION=2.5.0

# 3. Start the build (This will take about 3-5 minutes)
python3 setup.py install --user

cd ..
    fi
    #install aditional requrements
    reboot

