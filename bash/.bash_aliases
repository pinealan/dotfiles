# Single character that are taken (either alias or posix command)
# > a-cd-fgh---lmn-p--st-vw---

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
alias gdiff='git diff | grep + | wc && git diff | grep - | wc'
alias gupdate='git stash && git checkout master && git pull'
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

# JS
alias nlg='npm list -g -depth=0'

# CLI tools
alias a='ranger'
alias f='fzf'
alias m='man'
alias v='vim'
alias nv='nvim'
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

