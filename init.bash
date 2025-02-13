#!/bin/bash

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Rover ASCII animation function
rover_animation() {
    local -r task=$1
    local -r percentage=$2
    while true; do
        # Calculate rover position based on progress (percentage/100 * terminal width)
        local progress=$(( $percentage / 10 ))
        local pos=$(( ($progress) % $(tput cols) ))
        
        # Clear previous rover
        echo -n "\033[$prev_line;${pos-2}f "
        
        # Draw rover
        echo -n "\033[${line};${pos}fR"
        prev_line=$line
        
        sleep 0.1
    done
}

# Loading bar function with progress percentage
loading_bar() {
    local task_name=$1
    local percentage=$2
    echo -e "${BLUE}[INFO] ${task_name}...${NC}"
    for ((i=0; i<=100; i+=percentage)); do
        sleep 0.1
        printf "\r[ $(printf ':%.0s' {1..$i}) ] %d%%" "$i"
    done
}

# Main script functions
create_directories_and_clone() {
    echo -e "${BLUE}[INFO] Creating directories and cloning repositories...${NC}"
    
    # Create directories
    mkdir -p rovers/src/rovers/{bin,lib}
    echo -e "${GREEN}[DONE] Created necessary directories${NC}"
    
    # Clone repositories
    cd rovers/src/rovers/
    git clone https://github.com/autonomous-rovers/firmware.git
    git clone https://github.com/autonomous-rovers/planning.git
    git clone https://github.com/autonomous-rovers/simulation.git
    echo -e "${GREEN}[DONE] Cloned repositories${NC}"
}

# Main script execution
main() {
    echo -e "${BLUE}[INFO] Starting Autonomous Rovers Initialization...${NC}"
    
    # Task 1: Create directories and clone repositories (60% of total progress)
    create_directories_and_clone
    loading_bar "Creating directories and cloning" 60
    
    # Task 2: Install Flutter dependencies and setup (40% of total progress)
    echo -e "${BLUE}[INFO] Installing Flutter dependencies...${NC}"
    cd rovers/src/rovers/firmware/
    git checkout main
    ./setup.sh
    loading_bar "Installing Flutter dependencies" 40
    
    echo -e "${GREEN}[DONE] All tasks completed successfully!${NC}"
}

# Run the script
main

# Exit cleanly
exit 0
