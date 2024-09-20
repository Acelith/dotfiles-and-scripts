#!/bin/bash
######################################################
##################Programs#####################
######################################################

# Function to install VMware Workstation and its dependencies
vmwareInstall() {
    # Check if VMware is already installed
    if pacman -Qs "vmware" >/dev/null; then
        echo "vmware is already installed."
    else
        echo "begin installing vmware"

        echo "begin installing vmware dependencies"
        # Install necessary dependencies for VMware
        sudo pacman -S --noconfirm fuse2 gtkmm linux-headers pcsclite libcanberra
        paru -S --noconfirm --needed ncurses5-compat-libs
        paru -S --noconfirm --needed vmware-workstation

        echo "begin enabling vmware services"
        # Enable and start VMware services
        sudo systemctl enable vmware-networks.service vmware-usbarbitrator.service
        sudo systemctl start vmware-networks.service vmware-usbarbitrator.service
        echo "lazy load vmware modules"
        # Load VMware kernel modules
        sudo modprobe -a vmw_vmci vmmon
    fi
}

# Function to install Tuxedo Control Center and drivers
installTuxedoCenter() {
    # Install Tuxedo Control Center and drivers using yay
    yay -S tuxedo-control-center-bin tuxedo-drivers-dkms linux-headers

    echo "Please reboot the system"
}

# Function to install various applications using Flatpak
installFlatpakApps() {
    # Browsers
    flatpak install flathub one.ablaze.floorp --assumeyes
    flatpak install flathub com.brave.Browser --assumeyes
    # Communication
    flatpak install flathub org.mozilla.Thunderbird --assumeyes
    flatpak install flathub org.telegram.desktop --assumeyes
    # Development
    flatpak install flathub com.visualstudio.code --assumeyes
    flatpak install flathub com.axosoft.GitKraken --assumeyes
    # Entertainment
    flatpak install flathub com.spotify.Client --assumeyes
    flatpak install flathub com.valvesoftware.Steam --assumeyes
    # Tools
    flatpak install flathub com.github.tchx84.Flatseal --assumeyes
    flatpak install flathub io.typora.Typora --assumeyes
    flatpak install flathub org.onlyoffice.desktopeditors --assumeyes
    flatpak install flathub com.borgbase.Vorta --assumeyes
    flatpak install flathub com.termius.Termius --assumeyes
}

# Function to install various applications using Pacman
installPacmanApps() {
    sudo pacman -S --noconfirm ufw
    sudo ufw enable
    sudo pacman -S --noconfirm kitty
    sudo pacman -S --noconfirm neofetch
    sudo pacman -S --noconfirm btop
}

# Function to install AppImageLauncher
installAppImageLauncher() {
    # Download AppImageLauncher
    wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-lite-2.2.0-travis995-0f91801-x86_64.AppImage
    chmod 777 appimagelauncher-lite-2.2.0-travis995-0f91801-x86_64.AppImage
    # Install AppImageLauncher
    ./appimagelauncher-lite-2.2.0-travis995-0f91801-x86_64.AppImage install
}

# Function to install kDrive
# @TODO: Absolute link to the appimage, so might be broken in the future
installKdrive() {
    # Download kDrive AppImage
    wget https://download.storage.infomaniak.com/drive/desktopclient/kDrive-3.5.8.20240227-amd64.AppImage
    # Move kDrive AppImage to Applications directory
    mv kDrive-3.5.8.20240227-amd64.AppImage ~/Applications/
}

######################################################
##################Packet managers#####################
######################################################

# Function to install Homebrew package manager
installHomebrew() {
    # Check if Homebrew is already installed
    if pacman -Qs "brew" >/dev/null; then
        echo "brew is already installed."
    else
        echo "Installing brew."
        # Install base development tools
        sudo pacman -S base-devel
        # Add Homebrew to bashrc and initialize it
        (
            echo
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
        ) >>~/.bashrc
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        # Install garbage collector
        brew install gc
    fi
}

# Function to install Paru AUR helper
paruInstaller() {
    # Check if Paru is already installed
    if pacman -Qs "paru" >/dev/null; then
        echo "paru is already installed."
    else
        echo "begin installing paru"
        # Clone Paru repository and install it
        git clone https://aur.archlinux.org/paru-bin
        cd paru-bin/
        makepkg -si
    fi
}

# Function to install Yay AUR helper
yayInstaller() {
    # Check if Yay is already installed
    if pacman -Qs "yay" >/dev/null; then
        echo "yay is already installed."
    else
        # Install necessary tools for building packages
        sudo pacman -S --noconfirm --needed git base-devel

        # Clone Yay repository and install it
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si

        # Update Yay and installed packages
        yay -Syu

        echo "yay installed"
    fi
}

######################################################
##################System configuration################
######################################################

# Function to configure bashrc with custom aliases
configBashrc() {
    echo "alias ll='ls -la --color'" >>~/.bashrc
}
