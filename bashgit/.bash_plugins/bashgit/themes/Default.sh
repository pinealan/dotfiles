# Template theme for the bashgit plugin

override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Default"

  # GIT_PROMPT_PREFIX=""                # start of the git info string
  # GIT_PROMPT_SUFFIX=""                # the end of the git info string
  # GIT_PROMPT_SEPARATOR=""             # separates each item

  # GIT_PROMPT_BRANCH=""                # active git branch
  # GIT_PROMPT_MASTER_BRANCH=""         # used if active git branch is $GIT_PROMPT_MASTER_BRANCHES
  # GIT_PROMPT_STAGED=""                # the number of staged files/directories •
  # GIT_PROMPT_CHANGED=""               # the number of changed files
  # GIT_PROMPT_CONFLICTS=""             # the number of files in conflict

  # GIT_PROMPT_REMOTE=""                # the remote branch name (if any) and the symbols for ahead and behind
  # GIT_PROMPT_UNTRACKED=""             # the number of untracked files/dirs
  # GIT_PROMPT_STASHED=""               # the number of stashed files/dir
  # GIT_PROMPT_CLEAN=""                 # a colored flag indicating a "clean" repo

  # GIT_PROMPT_COMMAND_OK=""            # indicator if the last command returned with an exit code of 0
  # GIT_PROMPT_COMMAND_FAIL=""          # indicator if the last command returned with an exit code of other than 0

  ## template for displaying the current virtual environment
  ## the placeholder _VIRTUALENV_ will be replaced with the
  ## name of the current virtual environment (CONDA and VIRTUAL_ENV supported)
  # GIT_PROMPT_VIRTUALENV=""

  ## template for displaying the current remote tracking branch
  ## use the placeholder _UPSTREAM_ will be replaced with
  ## the name of the current remote tracking branch
  # GIT_PROMPT_UPSTREAM=" {${Blue}_UPSTREAM_${ResetColor}}"

  ## _LAST_COMMAND_INDICATOR_ will be replaced by the appropriate GIT_PROMPT_COMMAND_OK OR GIT_PROMPT_COMMAND_FAIL
  # GIT_PROMPT_START_USER=""
  # GIT_PROMPT_START_ROOT=""
  # GIT_PROMPT_END_USER=""
  # GIT_PROMPT_END_ROOT=""

  ## Please do not add colors to these symbols
  # GIT_PROMPT_SYMBOLS_AHEAD="↑·"               # The symbol for "n versions ahead of origin"
  # GIT_PROMPT_SYMBOLS_BEHIND="↓·"              # The symbol for "n versions behind of origin"
  # GIT_PROMPT_SYMBOLS_PREHASH=":"              # Written before hash of commit, if no name could be found
  # GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING=""    # This symbol is written after the branch, if the branch is not tracked

  ## branch name(s) that will use $GIT_PROMPT_MASTER_BRANCH color
  ## To specify multiple branches, use
  ##   shopt -s extglob
  ##   GIT_PROMPT_MASTER_BRANCHES='@(master|production)'
  # GIT_PROMPT_MASTER_BRANCHES="master"
}

reload_git_prompt_colors "Default"
