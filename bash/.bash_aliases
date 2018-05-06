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
alias dd='sudo dd status=progress'
alias df='df -h'
alias ds='du -sh *'
alias lsblk='lsblk -o NAME,LABEL,FSTYPE,SIZE,TYPE,MOUNTPOINT'
alias fdisk='sudo fdisk'
alias mount='sudo mount'

alias scs='systemctl status'
alias scstart='sudo systemctl start'
alias scstop='sudo systemctl stop'
alias screstart='sudo systemctl restart'
alias scenable='sudo systemctl enable'
alias scdisable='sudo systemctl disable'
alias scdr='sudo systemctl daemon-reload'

# Fun
alias mo='fortune | cowsay'
alias moo='mo'

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
alias g='git log --graph --stat --decorate --all'
alias gp='git log --graph --stat --decorate --patch'
alias gl='git log --graph --oneline --decorate --all --date-order -30'
alias gll='git log --graph --oneline --decorate --all'
alias gs='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'

alias gdiff='git diff | grep + | wc && git diff | grep - | wc'
alias git-list-tags=\
'for t in `git tag -l | sort -V --reverse`; '\
'do echo ""; '\
'echo "------------------------------------"; '\
'git cat-file -p `git rev-parse $t`; done;'

# NPM
alias nlg='npm list -g -depth=0'
