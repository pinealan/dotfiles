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
HISTFILESIZE=50000

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

export GLOBIGNORE=__pycache__

# Assumes 256 colors (8 bit)
export LESS_TERMCAP_mb=$'\e[1;31m'          # begin bold
export LESS_TERMCAP_md=$'\e[38;5;77m'       # begin blink
export LESS_TERMCAP_us=$'\e[38;5;185m'      # begin underline
export LESS_TERMCAP_me=$'\e[0m'             # end bold/blink
export LESS_TERMCAP_ue=$'\e[0m'             # end underline

export LESS_TERMCAP_so=$'\e[30;48;5;214m'   # standout-mode, dunno what this do
export LESS_TERMCAP_se=$'\e[0m'             # end standout-mode

export FZF_DEFAULT_COMMAND="fd . -H -L -t f -t l"
export FZF_DEFAULT_OPTS="\
    --height=30% \
    --min-height=10 \
    --cycle \
    --reverse \
    --border \
    --preview='head -n $COLUMNS {}'"

stty -ixon

# ----- Aliases -----

# Colors
alias ls='ls --color=auto -h'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rgrep='rgrep --color=auto'

rainbow () {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

# Builtins
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
cl() {
    cd $@ && ls -G;
}

# LS
alias l='ls -l'
alias lt='ls -t'
alias la='ls -lA'
alias ld='ls -al | grep " \."'
alias las='ls -lASF'
alias ll='LC_COLLATE=en_US.ascii ls -l'
alias lss='ls --color | less -R'
alias lhid='ls -la | grep " \\."'

# System Admin
alias h='htop'
alias df='df -h'
alias lsblk='lsblk -o NAME,LABEL,FSTYPE,SIZE,TYPE,MOUNTPOINT'
alias wa='which -a'
alias sl='echo $SHLVL'

ds () {
    if [[ -z $@ ]]; then
        args='*'
    else
        args=$@
    fi
    du -sh $args | sort -h
}

frequent_commands () {
    n=10

    while getopts "n:" opt; do
        case "$opt" in
        n)
            n=$OPTARG
            ;;
        esac
    done

    history | awk '{ if (length($2) > 1) print $2}' | sort | uniq -c | sort -nr | head -n"$n" | nl
}

alias scs='systemctl status'
alias scstart='sudo systemctl start'
alias scstop='sudo systemctl stop'
alias screstart='sudo systemctl restart'
alias scenable='sudo systemctl enable'
alias scdisable='sudo systemctl disable'
alias scdr='sudo systemctl daemon-reload'

# Vim
alias v='vim'
alias vim='nvim'
alias vd='vim -d'
alias svim='sudo env "PATH=$PATH" nvim'

alias vs='vim -S Session.vim'

# Tmux
alias t='tmux new -A -n shell -s default'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-server'

# Docker
alias dps='docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"'
alias dpsa='docker ps -a --format "table {{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

# Python
alias p='python'
alias p3='python3'
alias pm='python -m'
venv() {
    # use global venvs from $HOME if arg is provided
    if [[ -n $1 ]]; then
        . ~/venv/$1/bin/activate
        return
    fi

    # look for a venv in current directory
    for dir in "venv" ".venv" "env" ".env"; do
        if [[ -d $dir ]]; then
            . $dir/bin/activate
            return
        fi
    done

    # exit with error
    echo ERROR: Unable to find local environment >&2
    return 127
}

# JS
alias nlg='npm list -g -depth=0'

# CLI
alias serve='python3 -m http.server 5000'

alias a='ranger'
alias m='man'

# Fun
alias mo='fortune | cowsay'
alias moo='mo'
mooo () {
    while true; do
        str=`fortune -a`
        echo $str | cowsay
        sleep $((`echo $str | wc -c` / 40 + 2))
    done
}

# ----- Source more -----

# Execute optional extensions
if [ -d ~/.bash_plugins ]; then
    for f in ~/.bash_plugins/*; do
        [ -f $f ] && . $f
    done
fi

# Machine local bashrc
[ -f ~/.local/.bashrc ] && . ~/.local/.bashrc
