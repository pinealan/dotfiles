#!/usr/bin/env bash
#
# Source this file to enable git integration in bash
#
# Original: https://github.com/magicmonty/bash-git-prompt
# This copy is heavily optimized and customized for personal use
#
# ---[ Installation procedure ]---
# 1. gp_install_prompt
#    -  set $PROMPT_COMMAND
# 2. gp_set_dir
#    -  set $__GIT_PROMPT_DIR
# 3  gp_load_colors
#    - source prompt-colors.sh
# 4  gp_load_base_theme
#    - source theme.sh
# 5. gp_load_theme
#    - source theme from themes/
#
# ---[ Bash PROMPT_COMMAND procedure ]---
# 1. gp_set_last_exit
# 2. gp_set_prompt
#    1. gp_keep_old_prompt
#    2. gp_update
#    3. gp_add_virtualenv_to_prompt


# ---------------------
# | Utility functions |
# ---------------------

function we_are_on_repo() {
  if [[ -e "$(git rev-parse --git-dir 2> /dev/null)" ]]; then
    echo 1
  fi
  echo 0
}

function async_run() {
  {
    eval "$@" &> /dev/null
  }&
}

# Use exit status from declare command to determine if input is a bash function
function is_function() {
  declare -Ff "$1" >/dev/null;
}

function echoc() {
  echo -e "$1$2$ResetColor" | sed 's/\\\]//g'  | sed 's/\\\[//g'
}

# Helper function that truncates $PWD depending on window width
# Optionally specify maximum length as parameter (defaults to 1/3 of terminal)
function truncate_pwd {
  local tilde="~"
  local newPWD="${PWD/#${HOME}/${tilde}}"
  local pwdmaxlen=${1:-$((${COLUMNS:-80}/3))}
  [ ${#newPWD} -gt $pwdmaxlen ] && newPWD="...${newPWD:3-$pwdmaxlen}"
  echo -n "$newPWD"
}


# ------------------
# | User interface |
# ------------------

function gp_toggle() {
  if [[ "$GIT_PROMPT_DISABLE" = 1 ]]; then
    GIT_PROMPT_DISABLE=0
  else
    GIT_PROMPT_DISABLE=1
  fi
  return
}

function gp_list_themes() {
  for themefile in "${__GIT_PROMPT_DIR}/themes/"*; do
    local basename=${themefile##*/}
    local theme="${basename%.sh}"
    if [[ "$GIT_PROMPT_THEME" = "$theme" ]]; then
      echoc $Magenta "* $theme"
    else
      echo "  $theme"
    fi
  done
}

function gp_make_custom_theme() {
  if [[ -r "${__GIT_PROMPT_DIR}/themes/${1}.sh" ]]; then
    echoc $Red "You have already created a ${1} theme!"
  else
    echoc $Green     "Using theme ${Magenta}\"Default\"${Green} as base theme!"
    echoc $DimYellow "Please add ${Magenta}\"GIT_PROMPT_THEME=${1}\"${DimYellow} to your .bashrc to use this theme"
    cp "${__GIT_PROMPT_DIR}/themes/Default.sh" "${__GIT_PROMPT_DIR}/themes/${1}.sh"
  fi
}

# unsets installation related GIT_PROMPT variables
function gp_uninstall() {
  local var
  for var in GIT_PROMPT_DIR __GIT_PROMPT_COLORS_FILE __GIT_STATUS_CMD GIT_PROMPT_THEME_NAME; do
    unset $var
  done
}


# -----------------
# | Theme routine |
# -----------------

function gp_load_colors() {
  # outsource the color defs
  source "${__GIT_PROMPT_DIR}/prompt-colors.sh"
}

function gp_load_base_theme() {
  # outsource the skeleton theme defs
  source "${__GIT_PROMPT_DIR}/theme.sh"
}

function gp_load_theme() {
  if [[ -n $GIT_PROMPT_THEME ]]; then
    __GIT_PROMPT_THEME_FILE="${__GIT_PROMPT_DIR}/themes/${GIT_PROMPT_THEME}.sh"
  else
    __GIT_PROMPT_THEME_FILE="${__GIT_PROMPT_DIR}/themes/Default.sh}"
  fi

  source "$__GIT_PROMPT_THEME_FILE"
}

# gp_format_exit_status RETVAL
#
# echos the symbolic signal name represented by RETVAL if the process was
# signalled, otherwise echos the original value of RETVAL
#
function gp_format_exit_status() {
  local RETVAL="$1"
  local SIGNAL
  # Suppress STDERR in case RETVAL is not an integer (in such cases, RETVAL
  # is echoed verbatim)
  if [ "${RETVAL}" -gt 128 ] 2>/dev/null; then
    SIGNAL=$(( ${RETVAL} - 128 ))
    kill -l "${SIGNAL}" 2>/dev/null || echo "${RETVAL}"
  else
    echo "${RETVAL}"
  fi
}


# ---------------
# | Git routine |
# ---------------

# some versions of find do not have -mmin
_have_find_mmin=1

function olderThanMinutes() {
  local matches
  local find_exit_code

  if [[ -z "$_find_command" ]]; then
    if command -v gfind > /dev/null; then
      _find_command=gfind
    else
      _find_command=find
    fi
  fi

  if [[ "$_have_find_mmin" = 1 ]]; then
    matches=$("$_find_command" "$1" -mmin +"$2" 2> /dev/null)
    find_exit_code="$?"
    if [[ -n "$matches" ]]; then
      return 0
    else
      if [[ "$find_exit_code" != 0 ]]; then
        _have_find_mmin=0
      else
        return 1
      fi
    fi
  fi

  # try perl, solaris ships with perl
  if command -v perl > /dev/null; then
    perl -e '((time - (stat("'"$1"'"))[9]) / 60) > '"$2"' && exit(0) || exit(1)'
    return "$?"
  else
    echo >&2
    echo "[1;31mWARNING[0m: neither a find that supports -mmin (such as GNU find) or perl is available, disabling remote status checking. Install GNU find as gfind or perl to enable this feature, or set GIT_PROMPT_FETCH_REMOTE_STATUS=0 to disable this warning." >&2
    echo >&2
    GIT_PROMPT_FETCH_REMOTE_STATUS=0
    return 1
  fi
}

function checkUpstream() {
  local GIT_PROMPT_FETCH_TIMEOUT
  local FETCH_HEAD="$repo/.git/FETCH_HEAD"
  # Fech repo if local is stale for more than $GIT_FETCH_TIMEOUT minutes
  if [[ ! -e "$FETCH_HEAD" ]] || olderThanMinutes "$FETCH_HEAD" "$GIT_PROMPT_FETCH_TIMEOUT"
  then
    if [[ -n $(git remote show) ]]; then
      (
        async_run "git fetch --quiet"
        disown -h
      )
    fi
  fi
}

function replaceSymbols() {
  # Disable globbing, so a * could be used as symbol here
  set -f

  if [[ -z ${GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING} ]]; then
    GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING=L
  fi

  local VALUE=${1//_AHEAD_/${GIT_PROMPT_SYMBOLS_AHEAD}}
  local VALUE1=${VALUE//_BEHIND_/${GIT_PROMPT_SYMBOLS_BEHIND}}
  local VALUE2=${VALUE1//_NO_REMOTE_TRACKING_/${GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING}}

  echo ${VALUE2//_PREHASH_/${GIT_PROMPT_SYMBOLS_PREHASH}}

  # reenable globbing symbols
  set +f
}

function createPrivateIndex {
  # Create a copy of the index to avoid conflicts with parallel git commands, e.g. git rebase.
  local __GIT_INDEX_FILE
  local __GIT_INDEX_PRIVATE
  if [[ -z "$GIT_INDEX_FILE" ]]; then
    __GIT_INDEX_FILE="$(git rev-parse --git-dir)/index"
  else
    __GIT_INDEX_FILE="$GIT_INDEX_FILE"
  fi
  __GIT_INDEX_PRIVATE="/tmp/git-index-private$$"
  command cp "$__GIT_INDEX_FILE" "$__GIT_INDEX_PRIVATE" 2>/dev/null
  echo "$__GIT_INDEX_PRIVATE"
}


# -------------------------
# | Prompt update routine |
# -------------------------

function gp_config() {
  #Checking if root to change output
  _isroot=false
  [[ $UID -eq 0 ]] && _isroot=true

  if is_function prompt_callback; then
    prompt_callback="prompt_callback"
  else
    prompt_callback=:
  fi

  if [ "$GIT_PROMPT_LAST_COMMAND_STATE" == 0 ]; then
    LAST_COMMAND_INDICATOR="$GIT_PROMPT_COMMAND_OK";
  else
    LAST_COMMAND_INDICATOR="$GIT_PROMPT_COMMAND_FAIL";
  fi

  # replace _LAST_COMMAND_STATE_ token with the actual state
  GIT_PROMPT_LAST_COMMAND_STATE=$(gp_format_exit_status ${GIT_PROMPT_LAST_COMMAND_STATE})
  LAST_COMMAND_INDICATOR="${LAST_COMMAND_INDICATOR//_LAST_COMMAND_STATE_/${GIT_PROMPT_LAST_COMMAND_STATE}}"

  if $_isroot; then
    PROMPT_START="$GIT_PROMPT_START_ROOT"
  else
    PROMPT_START="$GIT_PROMPT_START_USER"
  fi

  if $_isroot; then
    PROMPT_END="$GIT_PROMPT_END_ROOT"
  else
    PROMPT_END="$GIT_PROMPT_END_USER"
  fi

  # set GIT_PROMPT_LEADING_SPACE to 0 if you want to have no leading space in front of the GIT prompt
  if [[ "$GIT_PROMPT_LEADING_SPACE" = 0 ]]; then
    PROMPT_LEADING_SPACE=""
  else
    PROMPT_LEADING_SPACE=" "
  fi

  if [[ "$GIT_PROMPT_ONLY_IN_REPO" = 1 ]]; then
    EMPTY_PROMPT="$OLD_PROMPT"
  else
    local ps="$(gp_add_virtualenv_to_prompt)$PROMPT_START$($prompt_callback)$PROMPT_END"
    EMPTY_PROMPT="${ps//_LAST_COMMAND_INDICATOR_/${LAST_COMMAND_INDICATOR}}"
  fi

  # fetch remote revisions every other $GIT_PROMPT_FETCH_TIMEOUT (default 5) minutes
  if [[ -z "$GIT_PROMPT_FETCH_TIMEOUT" ]]; then
    GIT_PROMPT_FETCH_TIMEOUT="5"
  fi

  unset GIT_BRANCH
}

function gp_update() {
  local LAST_COMMAND_INDICATOR
  local PROMPT_LEADING_SPACE
  local PROMPT_START
  local PROMPT_END
  local EMPTY_PROMPT

  gp_config

  export __GIT_PROMPT_IGNORE_STASH=${GIT_PROMPT_IGNORE_STASH}
  export __GIT_PROMPT_SHOW_UPSTREAM=${GIT_PROMPT_SHOW_UPSTREAM}
  export __GIT_PROMPT_IGNORE_SUBMODULES=${GIT_PROMPT_IGNORE_SUBMODULES}

  if [ -z "${GIT_PROMPT_SHOW_UNTRACKED_FILES}" ]; then
    export __GIT_PROMPT_SHOW_UNTRACKED_FILES=all
  else
    export __GIT_PROMPT_SHOW_UNTRACKED_FILES=${GIT_PROMPT_SHOW_UNTRACKED_FILES}
  fi

  if [ -z "${GIT_PROMPT_SHOW_CHANGED_FILES_COUNT}" ]; then
    export __GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=1
  else
    export __GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=${GIT_PROMPT_SHOW_CHANGED_FILES_COUNT}
  fi

  #important to define GIT_INDEX_FILE as local
  local GIT_INDEX_FILE
  local GIT_INDEX_PRIVATE="$(createPrivateIndex)"
  export GIT_INDEX_FILE="$GIT_INDEX_PRIVATE"

  local -a git_status_fields
  git_status_fields=($(${__GIT_PROMPT_DIR}/gitstatus.sh 2>/dev/null))

  export GIT_BRANCH=$(replaceSymbols ${git_status_fields[0]})
  local GIT_REMOTE="$(replaceSymbols ${git_status_fields[1]})"
  if [[ "." == "$GIT_REMOTE" ]]; then
    unset GIT_REMOTE
  fi

  local GIT_UPSTREAM_PRIVATE="${git_status_fields[2]}"
  if [[ -z "${__GIT_PROMPT_SHOW_UPSTREAM}" || "^" == "$GIT_UPSTREAM_PRIVATE" ]]; then
    unset GIT_UPSTREAM
  else
    export GIT_UPSTREAM=${GIT_UPSTREAM_PRIVATE}
    local GIT_FORMATTED_UPSTREAM="${GIT_PROMPT_UPSTREAM//_UPSTREAM_/\$GIT_UPSTREAM}"
  fi

  local GIT_STAGED=${git_status_fields[3]}
  local GIT_CONFLICTS=${git_status_fields[4]}
  local GIT_CHANGED=${git_status_fields[5]}
  local GIT_UNTRACKED=${git_status_fields[6]}
  local GIT_STASHED=${git_status_fields[7]}
  local GIT_CLEAN=${git_status_fields[8]}

  local NEW_PROMPT="$EMPTY_PROMPT"
  if [[ -n "$git_status_fields" ]]; then

    case "$GIT_BRANCH" in
      $GIT_PROMPT_MASTER_BRANCHES)
        local STATUS_PREFIX="${PROMPT_LEADING_SPACE}${GIT_PROMPT_PREFIX}${GIT_PROMPT_MASTER_BRANCH}\${GIT_BRANCH}${ResetColor}${GIT_FORMATTED_UPSTREAM}"
        ;;
      *)
        local STATUS_PREFIX="${PROMPT_LEADING_SPACE}${GIT_PROMPT_PREFIX}${GIT_PROMPT_BRANCH}\${GIT_BRANCH}${ResetColor}${GIT_FORMATTED_UPSTREAM}"
        ;;
    esac
    local STATUS=""

    # __add_status KIND VALEXPR INSERT
    # eg: __add_status  'STAGED' '-ne 0'

    __chk_gitvar_status() {
      local v
      if [[ "x$2" == "x-n" ]] ; then
        v="$2 \"\$GIT_$1\""
      else
        v="\$GIT_$1 $2"
      fi
      if eval "test $v" ; then
        if [[ $# -lt 2 || "$3" != '-' ]] && [[ "x$__GIT_PROMPT_SHOW_CHANGED_FILES_COUNT" == "x1" || "x$1" == "xREMOTE" ]]; then
          __add_status "\$GIT_PROMPT_$1\$GIT_$1\$ResetColor"
        else
          __add_status "\$GIT_PROMPT_$1\$ResetColor"
        fi
      fi
    }

    __add_gitvar_status() {
      __add_status "\$GIT_PROMPT_$1\$GIT_$1\$ResetColor"
    }

    # __add_status SOMETEXT
    __add_status() {
      eval "STATUS=\"$STATUS$1\""
    }

    __chk_gitvar_status 'REMOTE'     '-n'
    if [[ $GIT_CLEAN -eq 0 ]] || [[ $GIT_PROMPT_CLEAN != "" ]]; then
      __add_status        "$GIT_PROMPT_SEPARATOR"
      __chk_gitvar_status 'STAGED'     '!= "0" -a $GIT_STAGED != "^"'
      __chk_gitvar_status 'CONFLICTS'  '!= "0"'
      __chk_gitvar_status 'CHANGED'    '!= "0"'
      __chk_gitvar_status 'UNTRACKED'  '!= "0"'
      __chk_gitvar_status 'STASHED'    '!= "0"'
      __chk_gitvar_status 'CLEAN'      '= "1"'   -
    fi
    __add_status        "$ResetColor$GIT_PROMPT_SUFFIX"

    NEW_PROMPT="$(gp_add_virtualenv_to_prompt)$PROMPT_START$($prompt_callback)$STATUS_PREFIX$STATUS$PROMPT_END"
  else
    NEW_PROMPT="$EMPTY_PROMPT"
  fi

  PS1="${NEW_PROMPT//_LAST_COMMAND_INDICATOR_/${LAST_COMMAND_INDICATOR}${ResetColor}}"
  command rm "$GIT_INDEX_PRIVATE" 2>/dev/null
}

# Returns virtual env information to be set in prompt
# Honors virtualenvs own setting VIRTUAL_ENV_DISABLE_PROMPT
function gp_add_virtualenv_to_prompt {
  local ACCUMULATED_VENV_PROMPT=""
  local VENV=""
  if [[ -n "$VIRTUAL_ENV" && -z "${VIRTUAL_ENV_DISABLE_PROMPT-}" ]]; then
    VENV=$(basename "${VIRTUAL_ENV}")
    ACCUMULATED_VENV_PROMPT="${ACCUMULATED_VENV_PROMPT}${GIT_PROMPT_VIRTUALENV//_VIRTUALENV_/${VENV}}"
  fi
  if [[ -n "$NODE_VIRTUAL_ENV" && -z "${NODE_VIRTUAL_ENV_DISABLE_PROMPT-}" ]]; then
    VENV=$(basename "${NODE_VIRTUAL_ENV}")
    ACCUMULATED_VENV_PROMPT="${ACCUMULATED_VENV_PROMPT}${GIT_PROMPT_VIRTUALENV//_VIRTUALENV_/${VENV}}"
  fi
  if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    VENV=$(basename "${CONDA_DEFAULT_ENV}")
    ACCUMULATED_VENV_PROMPT="${ACCUMULATED_VENV_PROMPT}${GIT_PROMPT_VIRTUALENV//_VIRTUALENV_/${VENV}}"
  fi
  echo "$ACCUMULATED_VENV_PROMPT"
}

function gp_keep_old_prompt() {
  if [[ -z $GIT_PROMPT_OLD_DIR_WAS_GIT ]]; then
    OLD_PROMPT=$PS1
  fi
  GIT_PROMPT_OLD_DIR_WAS_GIT=$(we_are_on_repo)
}

function gp_set_prompt() {
  gp_keep_old_prompt

  local repo=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ ! -e "$repo" ]] && [[ "$GIT_PROMPT_ONLY_IN_REPO" = 1 ]]; then
    # we do not permit bash-git-prompt outside git repos, so nothing to do
    PS1="$OLD_PROMPT"
    return
  fi

  local EMPTY_PROMPT
  local __GIT_STATUS_CMD

  gp_config

  if [[ ! -e "$repo" ]] || [[ "$GIT_PROMPT_DISABLE" = 1 ]]; then
    PS1="$EMPTY_PROMPT"
    return
  fi

  local FETCH_REMOTE_STATUS=1
  if [[ "$GIT_PROMPT_FETCH_REMOTE_STATUS" = 0 ]]; then
    FETCH_REMOTE_STATUS=0
  fi

  unset GIT_PROMPT_IGNORE
  OLD_GIT_PROMPT_SHOW_UNTRACKED_FILES=${GIT_PROMPT_SHOW_UNTRACKED_FILES}
  unset GIT_PROMPT_SHOW_UNTRACKED_FILES

  OLD_GIT_PROMPT_IGNORE_SUBMODULES=${GIT_PROMPT_IGNORE_SUBMODULES}
  unset GIT_PROMPT_IGNORE_SUBMODULES

  if [[ -e "$repo/.bash-git-rc" ]]; then
    # The config file can only contain variable declarations on the form A_B=0 or G_P=all
    local CONFIG_SYNTAX="^(FETCH_REMOTE_STATUS|GIT_PROMPT_SHOW_UNTRACKED_FILES|GIT_PROMPT_IGNORE_SUBMODULES|GIT_PROMPT_IGNORE)=[0-9a-z]+$"
    if egrep -q -v "$CONFIG_SYNTAX" "$repo/.bash-git-rc"; then
      echo ".bash-git-rc can only contain variable values on the form NAME=value. Ignoring file." >&2
    else
      source "$repo/.bash-git-rc"
    fi
  fi

  if [ -z "${GIT_PROMPT_SHOW_UNTRACKED_FILES}" ]; then
    GIT_PROMPT_SHOW_UNTRACKED_FILES=${OLD_GIT_PROMPT_SHOW_UNTRACKED_FILES}
  fi
  unset OLD_GIT_PROMPT_SHOW_UNTRACKED_FILES

  if [ -z "${GIT_PROMPT_IGNORE_SUBMODULES}" ]; then
    GIT_PROMPT_IGNORE_SUBMODULES=${OLD_GIT_PROMPT_IGNORE_SUBMODULES}
  fi
  unset OLD_GIT_PROMPT_IGNORE_SUBMODULES

  if [[ "$GIT_PROMPT_IGNORE" = 1 ]]; then
    PS1="$EMPTY_PROMPT"
    return
  fi

  if [[ "$FETCH_REMOTE_STATUS" = 1 ]]; then
    checkUpstream
  fi

  gp_update
}

function gp_set_last_exit() {
  GIT_PROMPT_LAST_COMMAND_STATE=$?
}


# ------------------------
# | Installation routine |
# ------------------------

function gp_set_dir() {
  # assume the gitstatus.sh is in the same directory as this script
  # code thanks to http://stackoverflow.com/questions/59895
  if [ -z "$__GIT_PROMPT_DIR" ]; then
    local SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do
      local DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    __GIT_PROMPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  fi
}

function gp_install_prompt {
  if [ -z "$OLD_PROMPT" ]; then
    OLD_PROMPT=$PS1
  fi

  if [ -z "$GIT_PROMPT_OLD_DIR_WAS_GIT" ]; then
    GIT_PROMPT_OLD_DIR_WAS_GIT=$(we_are_on_repo)
  fi

  if [ -z "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND=gp_set_prompt
  else
    PROMPT_COMMAND=${PROMPT_COMMAND%% }; # remove trailing spaces
    PROMPT_COMMAND=${PROMPT_COMMAND%\;}; # remove trailing semi-colon
  fi

  local new_entry="gp_set_prompt"
  case ";$PROMPT_COMMAND;" in
    *";$new_entry;"*)
      # echo "PROMPT_COMMAND already contains: $new_entry"
      :;;
    *)
      PROMPT_COMMAND="$PROMPT_COMMAND;$new_entry"
      # echo "PROMPT_COMMAND does not contain: $new_entry"
      ;;
  esac

  local set_last_exit="gp_set_last_exit"
  case ";$PROMPT_COMMAND;" in
    *";$set_last_exit;"*)
      # echo "PROMPT_COMMAND already contains: $setLastCommandStateEntry"
      :;;
    *)
      PROMPT_COMMAND="$set_last_exit;$PROMPT_COMMAND"
      # echo "PROMPT_COMMAND does not contain: $setLastCommandStateEntry"
      ;;
  esac

}

gp_install_prompt
gp_set_dir
gp_load_colors
gp_load_base_theme
gp_load_theme
