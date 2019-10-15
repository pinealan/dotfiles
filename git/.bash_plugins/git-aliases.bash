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
