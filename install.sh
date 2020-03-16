#!/bin/sh

command -v stow 2>&1 > /dev/null || {
    echo >&2 "Require stow but it's not installed"; exit 1;
}

# configs commonly required on new machines
stow bash
stow bashgit
stow bin
stow git
stow nvim
stow tmux
stow vim
