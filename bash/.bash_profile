# this script is just a proxy to delagate to ~/.profile, which bash skips by
# default when ~/.bash_profile exists, messing up the de-factor shared UNIX
# shell settings that I use ~/.profile to configure

if [ -f "$HOME/.profile" ] ; then
    . "$HOME/.profile"
else
    export PATH=$HOME/.local/bin:$HOME/bin:$PATH
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
