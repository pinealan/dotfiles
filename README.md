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
Contains `.profile`, `.bashrc`, and `.bash_profile`. These sets up `PATH`
environment variables, tmux integration, and various bash configurations.

`~/.local/.profile`, `~/.local/.bashrc` and `~/.local/.bash_aliases` will be
sourced if they exist. These are for machine specific configs or aliases, and
should not be committed to this repo.

All files in directory `~/.bash_plugins/` will be sourced by bash. This is used
by the [bashgit](#bashgit) plugin that adds a git prompt to bash.

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
A heavily stripped down and styled version of
[bash-git-prompt](https://github.com/magicmonty/bash-git-prompt). This version
supports only bash and does not support switching themes.


### Conky
The conky config is heavily machine dependent since it requires various hardware
IDs to report on their status such as IO and Networking. The defaults are set to
work on an XPS15 9750.

Notably, here are things you might want to change:
- CPU/GPU numbers   (line 61-64)
- Filesystems       (line 80-81)
- WiFi              (line 85-89)
- Ethernet          (line 90-94)


### Git
Remember to change the user name, email, and github (or other git hosting
services) account.


### Tmux
Mainly color settings and shortcut re-bindings including changing the prefix key
to `Ctrl-A` from `Ctrl-B`. Adds
[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) which is a
plugin that allows save and restore of tmux sessions on an instance of the tmux
server.


### Vim
Vim packages are managed with [vim-plug](https://github.com/junegunn/vim-plug).
If it's your first time adopting this repository for your vim setup, upon first
launch of vim it will automatically detect vim-plug to be missing and install
both vim-plug and plugins specificed in the vimrc.

To migrate existing vundle setups, you may use the provided 
`vim/.vim/migrate-vundle-plug` script to clean up old `bunlde` directory and
install the plugins with vim-plug. Note that you will have to re-install
YouCompleteMe in `plugged/YouoCompleteMe` after the migration.
