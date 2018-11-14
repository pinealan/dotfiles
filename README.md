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
modern shell, but machine specific configs or aliases is often needed. To help
faciliate such logging settings, `.bashrc` sources `~/.local/.bashrc` and
`~/.local/.bash_aliases` at the end.


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
You would have to set up [Vundle](https://github.com/VundleVim/Vundle.vim) to
enable the many configured vim plugins that comes with the dotfiles. A helper
script `vim/.vim/setupvundle.sh` can help you to setup vundle and download all
plugins in one go.
