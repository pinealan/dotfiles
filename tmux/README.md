# True color

To enable true color in tmux, add this to the config
```
# Assuming your terminal emulators outputs $TERM as "xterm-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

- [Github issue](https://gist.github.com/XVilka/8346728) on true color
  support. After much work and discussion, [this
  comment](https://github.com/tmux/tmux/issues/34#issuecomment-241527745), which
  is the above example, would do the trick. I haven't identified the strings of
  PRs that implemented it yet.
- [End 2 end explanation](https://unix.stackexchange.com/a/181766) of color
  support from terminal, terminfo, tmux, and vim.
- [True Color test and support](https://gist.github.com/XVilka/8346728)

# Fix bold and italics on tmux

Assuming your terminal emulators doesn't have true color, this may become a
problem. Certain emulators doesn't sit well with tmux and tmux would fail to
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

