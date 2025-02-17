#!/bin/bash

LOG_FILE="update_log.txt"
echo "Starting installation process..." | tee -a $LOG_FILE
date | tee -a $LOG_FILE

# Function for loading bar
loading_bar() {
  local duration=$1
  local interval=0.1
  local end=$((duration / interval))
  for ((i=1; i<=end; i++)); do
    echo -n "#"
    sleep $interval
  done
}

# Update package lists and upgrade packages
echo "Running: sudo apt update" | tee -a $LOG_FILE
sudo apt update &> $LOG_FILE
loading_bar 5

echo "Running: sudo apt upgrade -y" | tee -a $LOG_FILE
sudo apt upgrade -y &> $LOG_FILE
loading_bar 10

# Install necessary packages and clone repositories
echo "Running: sudo apt-get install curl" | tee -a $LOG_FILE
sudo apt-get install curl &> $LOG_FILE
loading_bar 3

echo "Changing directory to Desktop" | tee -a $LOG_FILE
cd ~
mkdir -p ~/Desktop && cd ~/Desktop
git clone https://github.com/BinghamtonRover/Dashboard &> $LOG_FILE
loading_bar 2

git clone https://github.com/BinghamtonRover/Rover-Code &> $LOG_FILE
loading_bar 1

echo "Running: cd Downloads" | tee -a $LOG_FILE
cd ~
mkdir -p ~/Downloads && cd ~/Downloads
git clone https://github.com/NaiveInvestigator/flutter-installer &> $LOG_FILE
loading_bar 2

echo "Running: bash install.sh" | tee -a $LOG_FILE
bash install.sh &> $LOG_FILE
loading_bar 3

echo "Running: sudo apt-get install libasound2-dev" | tee -a $LOG_FILE
sudo apt-get install libasound2-dev &> $LOG_FILE
loading_bar 1

# Change directory to Dashboard and build the application
echo "Changing directory to Desktop/Dashboard" | tee -a $LOG_FILE
cd ~/Desktop/Dashboard
git pull &> $LOG_FILE
loading_bar 3

echo "Building flutter app: flutter build linux" | tee -a $LOG_FILE
flutter build linux &> $LOG_FILE
loading_bar 5

# Move the library file for compatibility
echo "Moving libSDL3.so to correct location" | tee -a $LOG_FILE
cd build/linux/x64/release/bundle/lib
mv libSDL3.so.0.1.5 libSDL3.so
cd ../../..

# Change directory to Rover-Code and run Dart application
echo "Changing directory to Desktop/Rover-Code" | tee -a $LOG_FILE
cd ~/Desktop/Rover-Code
git submodule update --init &> $LOG_FILE
git pull &> $LOG_FILE
loading_bar 2

echo "Running: dart run" | tee -a $LOG_FILE
dart run &> $LOG_FILE
loading_bar 5

date | tee -a $LOG_FILE
echo "Installation process completed." | tee -a $LOG_FILE
