# dotfiles-and-scripts

This personal repository contains my dotfiles and some scripts for customizations.

## Repository Structure

- **dotfiles/**: Contains configuration files for various tools and applications.
    - `.bashrc`: Configuration for the Bash shell.
    - `.vimrc`: Configuration for the Vim editor.
    - `.gitconfig`: Configuration for Git.
    - Other configuration files.

- **scripts/**: Contains useful scripts to automate and customize the system.
    - `install.sh`: Script to install the dotfiles on the system.
    - `backup.sh`: Script to backup existing dotfiles.
    - Other useful scripts.

## Usage

### Installing the dotfiles

To install the dotfiles on your system, run the following command:

```sh
./scripts/installDotFiles.sh
```

# TODO

- MIgrate to [chezmoi](https://www.chezmoi.io/) for managing all the files
- Migrate to Fastfetch
- Update the scripts for a global usage
- Separate file for script configs (Like links or paths)
- Update wallpapers with the offline collection
