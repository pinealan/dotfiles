# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Extend PATH only for level 1 shells,
# Fixes TMUX shell duplicate paths which are level 2 shells
if [ $SHLVL == 1 ]; then
    # prepend PATH with user's private bin directories
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
    [ -f "$HOME/.local/.profile" ] && . "$HOME/.local/.profile"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
