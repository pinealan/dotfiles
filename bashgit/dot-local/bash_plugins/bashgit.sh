GIT_PROMPT_DISABLE=0
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_IGNORE_SUBMODULES=1
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
GIT_PROMPT_SHOW_UPSTREAM=1

if command -v git &> /dev/null
then
    . $HOME/.local/bash_plugins/bashgit/gitprompt.sh
fi
