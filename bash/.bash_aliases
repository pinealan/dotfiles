# Cheat Sheet: single character aliases
# a  ranger
# c  clear
# d  git diff
# e  exit
# f  the fuck
# g  git log, with graph, commit messages, and stat
# h  htop
# l  ls, long form, directory first
# m  man
# n  ranger
# s  git status
# t  start tmux with default session
# v  vim
# w  <posix>
#
# Still available: b, i-k, o-r, u, x-z

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first -h'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls -h'
fi

# Shell
alias c='clear'
alias e='exit'

# List
alias l='ls -lFh'
alias lt='ls -lth'
alias la='ls -lAFh'
alias ld='ls -al | grep " \."'
alias las='ls -lASF'
alias ll='ls -l'
alias lha='ls -lAFSh'
alias lss='ls --color | less -R'
alias lhid='ls -la | grep \\.'

# System Admin
alias h='htop'
alias cut='cut -d " "'
alias df='df -h'
alias ds='du -sh *'
alias lsblk='lsblk -o NAME,LABEL,FSTYPE,SIZE,TYPE,MOUNTPOINT'

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

# Git
alias svim='sudo -E vim'
alias d='git diff'
alias s='git status'
alias g='git'
alias gp='git log --graph --stat --decorate --patch'
alias gl='git log --graph --oneline --decorate'
alias gla='git log --graph --oneline --decorate --all'
alias gll='git log --graph --oneline --decorate --all -30'
alias gs='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'
alias gdiff='git diff | grep + | wc && git diff | grep - | wc'
alias git-list-tags=\
'for t in `git tag -l | sort -V --reverse`; '\
'do echo ""; '\
'echo "------------------------------------"; '\
'git cat-file -p `git rev-parse $t`; done;'

# Python
alias p='python'
alias p3='python3'

alias venv='python3 -m venv'
ativ() {
    if [[ -z $1 ]]; then
        # find local venv
        . .venv/bin/activate
    else
        # use global venvs from $HOME
        . ~/venv/$1/bin/activate
    fi
}

# Fun
alias mo='fortune | cowsay'
alias moo='mo'

# Misc
alias nlg='npm list -g -depth=0'
alias ranger='ranger --choosedir=$HOME/.rangerdir; cd "$(cat $HOME/.rangerdir)"; rm $HOME/.rangerdir'
alias a='ranger'
alias f='fuck'
alias m='man'
alias n='ranger'
alias v='vim'
alias gg='git la'
alias serve='python3 -m http.server 5000'
