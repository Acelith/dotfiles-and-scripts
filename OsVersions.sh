#!/bin/bash
# PURPOSE: This script collects and displays information about the operating system versions and some software components.
# 
# DESCRIPTION:
# - Displays the Linux kernel version.
# - Displays the Plasma version.
# - Displays the NVIDIA driver versions.
# - Displays system information via Neofetch.
#
# USAGE:
# Run the script from the terminal to get the desired information.

source genericFunctions

create_dynamic_block "Linux version kernel"
uname -srm

create_dynamic_block "Versione Plasma"
plasmashell --version

create_dynamic_block "Versioni NVIDIA"

nvidia-smi


create_dynamic_block "Neofetch"
neofetch