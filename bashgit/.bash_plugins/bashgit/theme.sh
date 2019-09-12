define_default_git_prompt_colors() {
  # These are the color definitions used by gitprompt.sh
  # start of the git info string
  GIT_PROMPT_PREFIX="["
  # the end of the git info string
  GIT_PROMPT_SUFFIX="]"
  # separates each item
  GIT_PROMPT_SEPARATOR="|"

  # git branch that is active in the current directory
  GIT_PROMPT_BRANCH="${Magenta}"
  # used if the git branch that is active in the current directory is $GIT_PROMPT_MASTER_BRANCHES
  GIT_PROMPT_MASTER_BRANCH="${GIT_PROMPT_BRANCH}"
  # number of staged files/directories
  GIT_PROMPT_STAGED="${Red}●"
  # number of files in conflict
  GIT_PROMPT_CONFLICTS="${Red}✖ "
  # number of changed files
  GIT_PROMPT_CHANGED="${Blue}✚ "

  # remote branch name (if any) and the symbols for ahead and behind
  GIT_PROMPT_REMOTE=" "
  # number of untracked files/dirs
  GIT_PROMPT_UNTRACKED="${Cyan}…"
  # the number of stashed files/dir
  GIT_PROMPT_STASHED="${BoldBlue}⚑ "
  # a colored flag indicating a "clean" repo
  GIT_PROMPT_CLEAN="${BoldGreen}✔"

  # For the command indicator, the placeholder _LAST_COMMAND_STATE_
  # will be replaced with the exit code of the last command
  # e.g.
  # GIT_PROMPT_COMMAND_OK="${Green}✔-_LAST_COMMAND_STATE_ "    # indicator if the last command returned with an exit code of 0
  # GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_ "    # indicator if the last command returned with an exit code of other than 0

  # indicator if the last command returned with an exit code of 0
  GIT_PROMPT_COMMAND_OK="${Green}✔"
  # indicator if the last command returned with an exit code of other than 0
  GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_"

  # Possible to change which command is used to create git status information
  # There are three options:
  # 1) gitstatus.sh (uses git status --branch --porcelain - fast, requires git > 1.7.10)
  # 2) gitstatus_pre-1.7.10.sh (Uses a variety of git commands and pipes - slower, works with older git clients)
  # 3) gitstatus.py (Unsupported, lack features found in the bash versions)
  # Point out the command to get the git status from
  GIT_PROMPT_STATUS_COMMAND="gitstatus.sh"

  # template for displaying the current virtual environment
  # use the placeholder _VIRTUALENV_ will be replaced with
  # the name of the current virtual environment (currently CONDA and VIRTUAL_ENV)
  GIT_PROMPT_VIRTUALENV="(${Blue}_VIRTUALENV_${ResetColor}) "

  # template for displaying the current remote tracking branch
  # use the placeholder _UPSTREAM_ will be replaced with
  # the name of the current remote tracking branch
  GIT_PROMPT_UPSTREAM=" {${Blue}_UPSTREAM_${ResetColor}}"

  # _LAST_COMMAND_INDICATOR_ will be replaced by the appropriate GIT_PROMPT_COMMAND_OK OR GIT_PROMPT_COMMAND_FAIL
  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${Yellow}${PathShort}${ResetColor}"
  GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
  GIT_PROMPT_END_USER=" \n${White}${Time12a}${ResetColor} $ "
  GIT_PROMPT_END_ROOT=" \n${White}${Time12a}${ResetColor} # "

  # Please do not add colors to these symbols
  # The symbol for "n versions ahead of origin"
  GIT_PROMPT_SYMBOLS_AHEAD="↑·"
  # The symbol for "n versions behind of origin"
  GIT_PROMPT_SYMBOLS_BEHIND="↓·"
  # Written before hash of commit, if no name could be found
  GIT_PROMPT_SYMBOLS_PREHASH=":"

  # branch name(s) that will use $GIT_PROMPT_MASTER_BRANCH color
  # To specify multiple branches, use
  #   shopt -s extglob
  #   GIT_PROMPT_MASTER_BRANCHES='@(master|production)'
  GIT_PROMPT_MASTER_BRANCHES="master"
}

reload_git_prompt_colors() {
  if [[ "${GIT_PROMPT_THEME_NAME}" != $1 ]]; then
    define_default_git_prompt_colors
    override_git_prompt_colors
  fi
}

# vim: shiftwidth=2
