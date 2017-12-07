# System Admin
alias h='htop'
alias dd='dd status=progress'
alias df='df -h'
alias ds='du -sh *'

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
alias gl='git la'
alias gll='git ll'
alias gs='git stash'
alias gsp='git stash pop'

alias gdiff='git diff | grep + | wc && git diff | grep - | wc'
alias git-list-tags=\
'for t in `git tag -l | sort -V --reverse`; '\
'do echo ""; '\
'echo "------------------------------------"; '\
'git cat-file -p `git rev-parse $t`; done;'

# Anaconda Python
alias apython='/home/alan/miniconda3/bin/python'
alias apython3='/home/alan/miniconda3/bin/python3'

# NPM
alias nlg='npm list -g -depth=0'

# External hosts
rpi='192.168.0.11'

alias sftpi='sftp pi@$rpi'
alias sshpi='ssh pi@$rpi'
alias archon='ssh alan@brokefucker.com'
alias sftparchon='sftp alan@brokefucker.com'

# List
alias l='ls -lFh'
alias la='ls -lAF'
alias ld='ls -al | grep " \."'
alias las='ls -lASF'
alias ll='ls -l'
alias lha='ls -lAFSh'
alias lss='ls --color | less -R'
alias lhid='ls -la | grep \\.'

# Shortcuts
alias diary='vim ~/mfs/personal/memdump.md'
alias pandiary='pandoc -o ~/mfs/personal/diary.pdf ~/mfs/personal/memdump.md'

# Directory shortcuts
alias cdm='cd ~/mfs'
alias cdc='cd ~/mfs/code'
alias cds='cd ~/mfs/study'
alias cdev='cd ~/mfs/event'
alias cdpj='cd ~/mfs/project'
alias cdox='cd ~/mfs/study/oxford'

alias cdcc='cd ~/mfs/code/cc'
alias cdpy='cd ~/mfs/code/python'
alias cdsh='cd ~/mfs/code/bash'

alias cdbb='cd ~/mfs/project/algo/blackbox'
alias cdal='cd ~/mfs/project/algo'

# Fun
alias mo='fortune | cowsay'
alias moo='mo'
