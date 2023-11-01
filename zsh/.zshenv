# this script is just a proxy to delagate to ~/.profile, which zsh skips by
# default when ~/.zshenv exists and is not running in compatibility mode,
# messing up the de-factor shared UNIX shell settings that I use ~/.profile to
# configure

if [ -f "$HOME/.profile" ] ; then
    . "$HOME/.profile"
else
    export PATH=$HOME/.local/bin:$HOME/bin:$PATH
fi
