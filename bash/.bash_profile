if [ -f "$HOME/.profile" ] ; then
    . "$HOME/.profile"
else
    export PATH=$HOME/.local/bin:$HOME/bin:$PATH
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
