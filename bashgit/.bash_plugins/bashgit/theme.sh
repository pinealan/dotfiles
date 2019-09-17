## These are the color and format definitions used by gitprompt.sh

Time12a="\$(date +%H:%M)"
PathShort="\w"

# start of the git info string
GIT_PROMPT_PREFIX="["
# the end of the git info string
GIT_PROMPT_SUFFIX="]"
# separates each item
GIT_PROMPT_SEPARATOR=" |"

# the git branch that is active in the current directory
GIT_PROMPT_BRANCH="${Yellow}"
# used if the git branch that is active in the current directory is $GIT_PROMPT_MASTER_BRANCHES
GIT_PROMPT_MASTER_BRANCH="${DimYellow}"
# the number of staged files/directories •
GIT_PROMPT_STAGED=" ${Green}+"
# the number of changed files
GIT_PROMPT_CHANGED=" ${Red}+"
# the number of files in conflict
GIT_PROMPT_CONFLICTS=" ${BoldRed}✖"

# remote branch name (if any) and the symbols for ahead and behind
GIT_PROMPT_REMOTE=" "
# number of untracked files/dirs
GIT_PROMPT_UNTRACKED=" ${Yellow}∗"
# number of stashed files/dir
GIT_PROMPT_STASHED=" ${BoldMagenta}☗"
# a colored flag indicating a "clean" repo
GIT_PROMPT_CLEAN="" # "${Green}✔"

# For the command indicator, the placeholder _LAST_COMMAND_STATE_
# will be replaced with the exit code of the last command
# e.g.
# GIT_PROMPT_COMMAND_OK="${Green}✔-_LAST_COMMAND_STATE_ "    # indicator if the last command returned with an exit code of 0
# GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_ "    # indicator if the last command returned with an exit code of other than 0

# indicator if the last command returned with an exit code of 0
GIT_PROMPT_COMMAND_OK="${Green}✔"
# indicator if the last command returned with an exit code of other than 0
GIT_PROMPT_COMMAND_FAIL="${Red}✘ _LAST_COMMAND_STATE_"

# template for displaying the current virtual environment
# use the placeholder _VIRTUALENV_ will be replaced with
# the name of the current virtual environment (currently CONDA and VIRTUAL_ENV)
GIT_PROMPT_VIRTUALENV="${BrightBlack}(_VIRTUALENV_)${ResetColor} "

# template for displaying the current remote tracking branch
# use the placeholder _UPSTREAM_ will be replaced with
# the name of the current remote tracking branch
GIT_PROMPT_UPSTREAM=" (${Red}_UPSTREAM_${ResetColor})"

## _LAST_COMMAND_INDICATOR_ will be replaced by the appropriate GIT_PROMPT_COMMAND_OK OR GIT_PROMPT_COMMAND_FAIL
GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${BoldBlue}${PathShort}${ResetColor}"
GIT_PROMPT_END_USER="\n${Cyan}${Time12a}${BoldYellow} $ ${ResetColor}"

GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
GIT_PROMPT_END_ROOT="\n${Cyan}${Time12a}${Magenta} # ${ResetColor}"

# Please do not add colors to these symbols
# The symbol for "n versions ahead of origin"
GIT_PROMPT_SYMBOLS_AHEAD="↑·"
# The symbol for "n versions behind of origin"
GIT_PROMPT_SYMBOLS_BEHIND="↓·"
# Written before hash of commit, if no name could be found
GIT_PROMPT_SYMBOLS_PREHASH=":"
# This symbol is written after the branch, if the branch is not tracked
GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING=""

# branch name(s) that will use $GIT_PROMPT_MASTER_BRANCH color
# To specify multiple branches, use
#   shopt -s extglob
#   GIT_PROMPT_MASTER_BRANCHES='@(master|production)'
GIT_PROMPT_MASTER_BRANCHES="master"
