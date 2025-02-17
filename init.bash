#!/bin/bash
set -eo pipefail

LOG_FILE="update_log.txt"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Starting installation process..."
date

# Update package lists and upgrade packages
echo "Running: sudo apt update"
sudo apt update

echo "Running: sudo apt upgrade -y"
sudo apt upgrade -y

# Install necessary packages and clone repositories
echo "Running: sudo apt-get install curl"
sudo apt-get install -y curl

echo "Setting up Desktop directory"
mkdir -p ~/Desktop
cd ~/Desktop

# Clone repositories with existence checks
if [ ! -d "Dashboard" ]; then
  echo "Cloning Dashboard repository"
  git clone https://github.com/BinghamtonRover/Dashboard
else
  echo "Updating Dashboard repository"
  cd Dashboard && git pull && cd ..
fi

if [ ! -d "Rover-Code" ]; then
  echo "Cloning Rover-Code repository"
  git clone https://github.com/BinghamtonRover/Rover-Code
else
  echo "Updating Rover-Code repository"
  cd Rover-Code && git pull && cd ..
fi

echo "Setting up Downloads directory"
mkdir -p ~/Downloads
cd ~/Downloads

if [ ! -d "flutter-installer" ]; then
  echo "Cloning flutter-installer repository"
  git clone https://github.com/NaiveInvestigator/flutter-installer
else
  echo "flutter-installer already exists, updating"
  cd flutter-installer && git pull && cd ..
fi

echo "Running flutter installer"
cd flutter-installer
bash install.sh

echo "Installing audio dependencies"
sudo apt-get install -y libasound2-dev

# Build Dashboard application
echo "Building Dashboard application"
cd ~/Desktop/Dashboard
git pull

echo "Installing flutter dependencies"
flutter pub get

echo "Building Linux release"
flutter build linux

# Handle SDL3 library
echo "Updating SDL3 library"
cd build/linux/x64/release/bundle/lib
if ls libSDL3.so.* 1>/dev/null 2>&1; then
  lib_file=$(ls libSDL3.so.* | head -n1)
  mv -v "$lib_file" libSDL3.so
  echo "Library updated successfully"
else
  echo "Error: libSDL3.so.* not found!" >&2
  exit 1
fi

# Setup Rover-Code
echo "Setting up Rover-Code"
cd ~/Desktop/Rover-Code
git submodule update --init
git pull

echo "Running Rover application"
dart run

echo "Installation process completed successfully!"
date
