set -x VISUAL=vim
set -x EDITOR="$VISUAL"
set -x GLOBIGNORE=__pycache__

set -x LESS_TERMCAP_mb=$'\e[1;31m'          # begin bold
set -x LESS_TERMCAP_md=$'\e[38;5;77m'       # begin blink
set -x LESS_TERMCAP_us=$'\e[38;5;185m'      # begin underline
set -x LESS_TERMCAP_me=$'\e[0m'             # end bold/blink
set -x LESS_TERMCAP_ue=$'\e[0m'             # end underline

set -x LESS_TERMCAP_so=$'\e[30;48;5;214m'   # standout-mode, dunno what this do
set -x LESS_TERMCAP_se=$'\e[0m'             # end standout-mode

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
