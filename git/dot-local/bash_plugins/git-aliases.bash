# Bash aliases for Git
# Some depends on git-aliases from the gitconfig
#

alias d='git diff'
alias s='git status'
alias g='git'
alias gg='tig'
alias ga='gg --all'
alias gs='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'
alias gdiff='git diff | grep + | wc && git diff | grep - | wc'
alias gupdate='git stash && git checkout master && git pull'

alias gnow='git l -n 50 master HEAD'
alias glocal='gnow --branches master HEAD'
alias gall='gnow --all'

alias gw='{ ls .git/{index,FETCH_HEAD,HEAD}; find .git/refs; } | entr -c git l'
alias gwlatest='gw -n 50'
alias gwlocal='gw -n 50 --branches master HEAD'
alias gwan='gw --all -n'
