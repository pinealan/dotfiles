# Fix bold and italics on tmux
Certain terminal emulators doesn't sit well with tmux and tmux would fail to
display bold or italic text properly. This can be fixed by monkey patching the
$TERM variable that tmux uses and create a terminfo for that specific $TERM.

## Gnome terminal, Xfce terminal, xterm
Add the terminfo entry to the terminfo database using the provide terminfo file
```
tic tmux-256color-it.terminfo
```

Then uncomment the following line in `.tmux.conf`
```
# Enable colors and italics
#set -g default-terminal "tmux-256color-it"
```
