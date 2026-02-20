# === Envvar ===
set -x VISUAL vim
set -x EDITOR "$VISUAL"
set -x GLOBIGNORE __pycache__

set -x LESS_TERMCAP_mb \e'[1;31m'          # begin bold
set -x LESS_TERMCAP_md \e'[38;5;77m'       # begin blink
set -x LESS_TERMCAP_us \e'[38;5;185m'      # begin underline
set -x LESS_TERMCAP_me \e'[0m'             # end bold/blink
set -x LESS_TERMCAP_ue \e'[0m'             # end underline

set -x LESS_TERMCAP_so \e'[30;48;5;214m'   # standout-mode, dunno what this do
set -x LESS_TERMCAP_se \e'[0m'             # end standout-mode

# === Alias ===
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

# List
alias l='ls -lFh'
alias lt='ls -lth'
alias la='ls -lAFh'
alias ld='ls -al | grep " \."'
alias las='ls -lASF'
alias ll='ls -l'
alias lha='ls -lAFSh'
alias lss='ls --color | less -R'
alias lhid='ls -la | grep " \\."'

# System Admin
alias h='htop'
alias df='df -h'
alias ds='du -sh *'
alias cut='cut -d " "'
alias svim='sudo -E vim'
alias lsblk='lsblk -o NAME,LABEL,FSTYPE,SIZE,TYPE,MOUNTPOINT'

# Tmux
alias t='tmux new -A -n shell -s default'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-server'

# Git
alias d='git diff'
alias s='git status'
alias g='git'
alias gg='git la'
alias ga='git add .'
alias gp='git log --graph --stat --decorate --patch'
alias gl='git log --graph --oneline --decorate'
alias gla='git log --graph --oneline --decorate --all'
alias gll='git log --graph --oneline --decorate --all -30'
alias gpg='git push github'
alias gs='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'
alias gdiff='git diff | grep + | wc; git diff | grep - | wc'
alias gupdate='git stash; git checkout master; git pull'

alias tig='tig --all'

# Docker
alias dps='docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"'

# CLI tools
alias a='ranger'
alias f='fzf'
alias m='man'
alias v='vim'
alias nv='nvim'
alias serve='python3 -m http.server 5000'
# todo fix
# alias ranger="ranger --choosedir=$HOME/.rangerdir; cd "(cat "$HOME/.rangerdir")"; rm $HOME/.rangerdir"
