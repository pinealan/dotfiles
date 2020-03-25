# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.

# prepend PATH with user's home bin directories
PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# execute local machine-specific .profile if it exists
[ -f "$HOME/.local/.profile" ] && . "$HOME/.local/.profile"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
