# Bash aliases for Git
# Some depends on git-aliases from the gitconfig
#

alias d='git diff'
alias s='git status'
alias g='git'
alias gg='git la'
alias ga='git add .'
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

alias glatest='git l -n 50 master HEAD'
alias glocal='glatest --branches master HEAD'
alias gall='glatest --all'

alias gw='{ ls .git/{index,FETCH_HEAD,HEAD}; find .git/refs; } | entr -c git l'
alias gwlatest='gw -n 50'
alias gwlocal='gw -n 50 --branches master HEAD'
alias gwan='gw --all -n'

git-show-file() {
    if [[ -z $1 ]]; then
        echo ERROR: First arguemnt must be file path >&2
        return 1
    fi

    path=$1
    shift

    git show $(git log --follow --pretty=format:%H $path) $@
}
