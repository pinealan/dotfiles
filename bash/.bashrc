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
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

export VISUAL=vim
export EDITOR="$VISUAL"
export GLOBIGNORE=__pycache__

export LESS_TERMCAP_mb=$'\e[1;31m'          # begin bold
export LESS_TERMCAP_md=$'\e[38;5;77m'       # begin blink
export LESS_TERMCAP_us=$'\e[38;5;185m'      # begin underline
export LESS_TERMCAP_me=$'\e[0m'             # end bold/blink
export LESS_TERMCAP_ue=$'\e[0m'             # end underline

export LESS_TERMCAP_so=$'\e[30;48;5;214m'   # standout-mode, dunno what this do
export LESS_TERMCAP_se=$'\e[0m'             # end standout-mode

export FZF_DEFAULT_COMMAND="find . -type f -not -path '*node_modules*' -not -path '*coverage*'"
export FZF_DEFAULT_OPTS="\
    --height=30% \
    --min-height=10 \
    --cycle \
    --reverse \
    --border \
    --preview='head -n $COLUMNS {}'"

stty -ixon

# ----- Aliases -----

# Single character that are taken (either alias or posix command)
# > a-cd-fgh---lmn-p--st-vw---

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto --group-directories-first -h'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rgrep='rgrep --color=auto'

# Shell
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
cl() {
    cd $@ && ls -G;
}

# List
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
alias ds='du -sh *'
alias cut='cut -d " "'
alias svim='sudo -E vim'
alias lsblk='lsblk -o NAME,LABEL,FSTYPE,SIZE,TYPE,MOUNTPOINT'
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

# Tmux
alias t='tmux new -A -n shell -s default'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-server'

alias tig='tig --all'

# Docker
alias dps='docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"'
alias dpsa='docker ps -a --format "table {{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

# Python
alias p='python'
alias p3='python3'
venv() {
    if [[ -z $1 ]]; then
        not_found=1

        # find local venv
        for dir in "venv" ".venv" "env" ".env"; do
            if [[ -d $dir ]]; then
                . $dir/bin/activate
                unset not_found
                break
            fi
        done

        if [[ -n $not_found ]]; then
            echo ERROR: Unable to find local environment >&2
            return 127
        fi
    else
        # use global venvs from $HOME
        . ~/venv/$1/bin/activate
    fi
}

# JS
alias nlg='npm list -g -depth=0'

# CLI tools
alias a='ranger'
alias f='fzf'
alias m='man'
alias v='vim'
alias nv='nvim'
alias vd='vim -d'
alias serve='python3 -m http.server 5000'
alias ranger='ranger --choosedir=$HOME/.rangerdir; cd "$(cat $HOME/.rangerdir)"; rm $HOME/.rangerdir'

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

alias vz='vim $(fzf)'

# ----- Source more -----

# Execute optional extensions
if [ -d ~/.bash_plugins ]; then
    for f in ~/.bash_plugins/*; do
        [ -f $f ] && . $f
    done
fi

# Machine local bashrc
[ -f ~/.local/.bashrc ] && . ~/.local/.bashrc
