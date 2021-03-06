# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth:ignoredups:erasedups

# set history length in memory for individual shell instance
HISTSIZE=5000

# history file size, average cmd is 30 characters, should only be ~1.5MB
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# check for terminal color capabilities
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
fi

# set prompt
if [ "$color_prompt" = yes ]; then
    PS1="\[\e[32m\]\u\[\e[00m\]@\[\e[32m\]\h\[\e[00m\]"
    PS1="$PS1 \[\e[01;34m\]\w\[\e[00m\]\n\[\e[01;33m\]"
    PS1="$PS1\[\e[0;36m\]$(date +%H:%M)\[\e[1;33m\] \$\[\e[00m\] "
else
    PS1="\u@\h \w\n\$ "
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
esac

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# add zsh like Tab Completion to bash
bind -l | grep -q show && (
    bind 'set show-all-if-ambiguous on'
    bind 'set show-all-if-unmodifed on'
)
bind 'set menu-complete-display-prefix off'
bind 'set print-completions-horizontally on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

stty -ixon

# ----- Source more -----

# Execute optional extensions
local_bash_plugins="$HOME/.local/bash_plugins"
if [ -d $local_bash_plugins ]; then
    for f in $local_bash_plugins/*; do
        [ -f $f ] && . $f
    done
fi

# Machine local bashrc
local_bashrc="$HOME/.local/bashrc"
[ -f $local_bashrc ] && . $local_bashrc
