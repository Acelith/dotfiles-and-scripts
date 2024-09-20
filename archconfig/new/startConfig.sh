#!/bin/bash

source functions.sh
#Configs
configBashrc
installForeignCharacters

# Install packet managers
paruInstaller
yayInstaller
installHomebrew

# Install apps
installFlatpakApps
vmwareInstall
installTuxedoCenter
installAppImageLauncher
installKdrive