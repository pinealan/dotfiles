# prepend PATH with user's home bin directories
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export FZF_DEFAULT_COMMAND="fd . -HIL -t f -t l"
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

alias g='git'
alias h='htop'
alias v='vim'
alias df='df -h'
alias sl='echo $SHLVL'
alias wa='which -a'

# execute local machine-specific .profile if it exists
local_profile="$HOME/.local/profile"
[ -f  $local_profile ] && . $local_profile
