# Single character that are taken (either alias or posix command)
# > __cd_fgh___lm_____st_vw___
# > abcdefghijklmnopqrstuvwxyz

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first -h'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='rgrep --color=auto'
else
    alias ls='ls -h'
fi

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
alias ga='git add .'
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

alias tig='tig --all'

# Docker
alias dps='docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"'

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

        if [[ -v not_found ]]; then
            echo ERROR: Unable to find local environment >&2
            return 127
        fi
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
alias m='man'
alias v='vim'
alias nv='nvim'
alias gg='git la'
alias serve='python3 -m http.server 5000'
alias f='fzf'
