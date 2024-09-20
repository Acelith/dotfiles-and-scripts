#!/bin/bash

# Array of valid parameters
valid_args=("--autoremove" "--music" "--git" "--all" "--help")

# Check if any parameters were passed
if [[ $# -eq 0 ]]; then
  echo "Error: no parameters specified."
  echo "Usage: [${valid_args[*]}]"
  exit 1
fi

# Display help
if [[ $1 == "--help" ]]; then
  echo "Usage: $0 [parameter]"
  echo "Valid parameters:"
  echo "  ${valid_args[0]} - Executes autoremove and clean"
  echo "  ${valid_args[1]} - Downloads music from the MH YouTube playlist"
  echo "  ${valid_args[2]} - Synchronizes the Git repository"
  echo "  ${valid_args[3]} - Executes all the above update actions"
  echo "  ${valid_args[4]} - Displays this help message"
  exit 0
fi

# Synchronize the system clock
sudo ntpd

# Import personal libraries
source genericFunctions

# Save the working directory
pwd=$(pwd)

# Function declarations

# Function to download music
function trigger_music() {
  linkPlaylist=https://youtube.com/playlist?list=PLyNFIyB-Y_IkBxtLIjzapGeIRYP4x44Lt&si=Kq9EJVFuWWyjlEGD
  create_dynamic_block "Music"
  # Move to a temporary directory to avoid temporary files in the pwd
  cd ~/kDrive/Media/MH/ || exit 1
  yt-dlp -f bestvideo*+bestaudio/best --download-archive ~/kDrive/Media/MH/archive.txt -P ~/kDrive/Media/MH/ "$linkPlaylist"
  cd "$pwd" || exit
}

# Function for autoremove
function trigger_autoremove() {
  create_dynamic_block "Autoremove"
  sudo apt autoremove || exit 1
}

# Function for clean
function trigger_clean() {
  create_dynamic_block "AutoClean"
  sudo apt-get clean || exit 1
}

# Function for Home Brew
function trigger_brew() {
  create_dynamic_block "Home Brew"
  brew update
  brew upgrade
  brew update --auto-update
}

# Function for Git synchronization
function trigger_git() {
  # Move to the Git repository directory
  cd ~/Documents/Scripts/ext/yt-dlp/ || exit 1

  # Git synchronization block
  create_dynamic_block "Pull Git Repository"
  gh repo sync || exit 1

  cd "$pwd" || exit 1
}

# Function for Flatpak updates
function trigger_flatpak(){
  create_dynamic_block "Flatpak Updates" 
  flatpak update
}

# End of function declarations

# Update block
create_dynamic_block "Update"
sudo apt update || exit 1

create_dynamic_block "Upgrade"
sudo apt upgrade || exit 1

# Home Brew block
trigger_brew

# Parameter handling

# Loop to analyze parameters
for arg in "$@"; do
  case "$arg" in
  "${valid_args[0]}")
    trigger_autoremove
    trigger_clean
    break
    ;;
  "${valid_args[1]}")
    trigger_music
    break
    ;;
  "${valid_args[2]}")
    #trigger_git
    create_dynamic_block "GIT Disabled, edit script to enable"
    break
    ;;
  "${valid_args[3]}")
    trigger_autoremove
    trigger_music
    #trigger_git
    create_dynamic_block "GIT Disabled, edit script to enable"
    trigger_flatpak
    break
    ;;
  *)
    echo "Error: unrecognized parameter '$arg'."
    echo "Usage: $0 [${valid_args[*]}]"
    exit 1
    ;;
  esac
done

# Trap for cancellation (Ctrl+C)
trap 'echo "Operation canceled"; exit 1' INT
