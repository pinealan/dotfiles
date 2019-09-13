# Dotfiles - Alan Chan
_Disclaimer: These dotilfes were written with only myself in mind. Use at your
own risk_

These dotfiles are organised to be managed with [GNU
stow](https://www.gnu.org/software/stow/manual/stow.html). Here's my short
summary of stow, inspired by the stow homepage description:

> GNU Stow is a symlink manager that uses symlinks to make files appear from the 
> source package directory appear to be installed at the destination.


## Installation
Stow does not come pre-installed with most distribution. On debian systems,
install it with the command:
```bash
sudo apt install stow
```

Clone this repository at your home folder and start stowing away
```bash
cd ~
git clone https://github.com/pinealan/dotfiles
cd dotfiles
stow bash
```


## Packages config
### Bash
Bash's main configuration (and often default) files are `~/.bashrc` and
`.bash_aliases`. This repo's bash dotfiles provide sensible defaults for a
modern shell. For machine specific configs or aliases, scripts in `~/.local`
directory such as `~/.local/.bashrc` and `~/.local/.bash_aliases` be sourced is
they exist. Plugins can also be put in a `~/.bash_plugins/` directory, where all
files will be sourced as bash scripts.

The following is the complete order in which bash scripts are source. Later
scripts inherit and can override the environment set up by earlier scripts.

  .profile
  .bashrc
  .bash_profile
  .bash_aliases
  .bash_plugins/*
  .local/.bashrc
  .local/.bash_aliases
  .local/.profile


### Bashgit
A heavily modified version of
[bash-git-prompt](https://github.com/magicmonty/bash-git-prompt) comes with this
repo. This version supports only bash shells.


### Conky
The conky config is heavily machine dependent since it requires various hardware
IDs to report on their status such as IO and Networking.

Notably, here are things you might want to change:
- CPU/GPU numbers   (line 61-64)
- Filesystems       (line 80-81)
- WiFi              (line 85-89)
- Ethernet          (line 90-94)


### Git
Remember to change the user name, email, and github (or other git hosting
services) account.


### Vim
Vim packages are managed with [vim-plug](https://github.com/junegunn/vim-plug).
If it's your first time adopting this repository for your vim setup, upon first
launch of vim it will automatically detect vim-plug to be missing and install
both vim-plug and plugins specificed in the vimrc.

To migrate existing vundle setups, you may use the provided 
`vim/.vim/migrate-vundle-plug` script to clean up old `bunlde` directory and
install the plugins with vim-plug. Note that you will have to re-install
YouCompleteMe in `plugged/YouoCompleteMe` after the migration.
