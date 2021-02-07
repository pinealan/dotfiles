# POSIX compliant shell configs

# prepend PATH with user's home bin directories
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export FZF_DEFAULT_COMMAND="fd . -HIL -t f -t l"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="\
    --height=30% \
    --min-height=10 \
    --cycle \
    --reverse \
    --border \
    --preview='head -n $COLUMNS {}'"

# POXIS Builtins
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Docker
alias dps='docker ps --format "table {{.Image}}\t{{.Status}}\t{{.Names}}"'
alias dpsa='docker ps -a --format "table {{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias drdp='docker run -d -p'

# Tmux
alias t='tmux new -A -n shell -s default'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-server'

# ls
alias l='ls -l'
alias lt='ls -t'
alias la='ls -lA'
alias ld='ls -al | grep " \."'
alias las='ls -lASF'
alias ll='LC_COLLATE=en_US.ascii ls -l'
alias lss='ls --color | less -R'
alias lhid='ls -la | grep " \\."'

# Git
alias d='git diff'
alias s='git status'
alias gg='tig'
alias ga='gg --all'
alias gs='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'

# Shorthands
alias g='git'
alias h='htop'
alias v='vim'
alias df='df -h'
alias sl='echo $SHLVL'
alias wa='which -a'

# Assumes 256 colors (8 bit)
export LESS_TERMCAP_mb=$'\e[1;31m'          # begin bold
export LESS_TERMCAP_md=$'\e[38;5;77m'       # begin blink
export LESS_TERMCAP_us=$'\e[38;5;185m'      # begin underline
export LESS_TERMCAP_me=$'\e[0m'             # end bold/blink
export LESS_TERMCAP_ue=$'\e[0m'             # end underline

export LESS_TERMCAP_so=$'\e[30;48;5;214m'   # standout-mode, dunno what this do
export LESS_TERMCAP_se=$'\e[0m'             # end standout-mode

# execute local machine-specific .profile if it exists
local_profile="$HOME/.local/profile"
[ -f  $local_profile ] && . $local_profile
