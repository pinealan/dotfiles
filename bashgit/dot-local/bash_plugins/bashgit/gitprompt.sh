#!/usr/bin/env bash
#
# Source this file to enable git integration in bash
#
# Original: https://github.com/magicmonty/bash-git-prompt
# This copy is heavily stripped down, refactored, and customized for personal use
#
# ---[ Bash PROMPT_COMMAND procedure ]---
# 1. gp-set-last-exit
# 2. gp-set-prompt
#    a. gp-keep-old-prompt
#    b. gp-config
#    c. gp-update
#    d. gp-add-env-to-prompt


# ---------------------
# | Utility functions |
# ---------------------

function we_are_on_repo() {
  if [[ -e "$(git rev-parse --git-dir 2> /dev/null)" ]]; then
    echo 1
  fi
  echo 0
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

function gp-toggle() {
  [[ "$GIT_PROMPT_DISABLE" = 1 ]] && GIT_PROMPT_DISABLE=0 || GIT_PROMPT_DISABLE=1
  return
}


# ---------------
# | Git routine |
# ---------------

function replaceSymbols() {
  # Disable globbing, so a * could be used as symbol here
  set -f

  local VALUE
  VALUE=${1//_AHEAD_/${GIT_PROMPT_SYMBOLS_AHEAD}}
  VALUE=${VALUE//_BEHIND_/${GIT_PROMPT_SYMBOLS_BEHIND}}
  VALUE=${VALUE//_NO_REMOTE_TRACKING_/${GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING}}

  echo ${VALUE//_PREHASH_/${GIT_PROMPT_SYMBOLS_PREHASH}}

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

# gp-format-exit-status RETVAL
#
# echos the symbolic signal name represented by RETVAL if the process was
# signalled, otherwise echos the original value of RETVAL
#
function gp-format-exit-status() {
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

function gp-config() {
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
  GIT_PROMPT_LAST_COMMAND_STATE=$(gp-format-exit-status ${GIT_PROMPT_LAST_COMMAND_STATE})
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
    local ps="$(gp-add-env-to-prompt)$PROMPT_START$($prompt_callback)$PROMPT_END"
    EMPTY_PROMPT="${ps//_LAST_COMMAND_INDICATOR_/${LAST_COMMAND_INDICATOR}}"
  fi

  # fetch remote revisions every other $GIT_PROMPT_FETCH_TIMEOUT (default 5) minutes
  if [[ -z "$GIT_PROMPT_FETCH_TIMEOUT" ]]; then
    GIT_PROMPT_FETCH_TIMEOUT="5"
  fi

  unset GIT_BRANCH
}

function gp-update() {
  local LAST_COMMAND_INDICATOR
  local PROMPT_LEADING_SPACE
  local PROMPT_START
  local PROMPT_END
  local EMPTY_PROMPT

  gp-config

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

    NEW_PROMPT="$(gp-add-env-to-prompt)$PROMPT_START$($prompt_callback)$STATUS_PREFIX$STATUS$PROMPT_END"
  else
    NEW_PROMPT="$EMPTY_PROMPT"
  fi

  PS1="${NEW_PROMPT//_LAST_COMMAND_INDICATOR_/${LAST_COMMAND_INDICATOR}${ResetColor}}"
  command rm "$GIT_INDEX_PRIVATE" 2>/dev/null
}

# Returns env information to be set in prompt
# Supports the following environment management tools:
# - virtualenv / venv
# - nodeenv
# - conda
# Honors virtualenvs own setting VIRTUAL_ENV_DISABLE_PROMPT
function gp-add-env-to-prompt {
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
  if [[ -n "$IN_NIX_SHELL" ]]; then
    VENV="nix-${IN_NIX_SHELL}"
    ACCUMULATED_VENV_PROMPT="${ACCUMULATED_VENV_PROMPT}${GIT_PROMPT_VIRTUALENV//_VIRTUALENV_/${VENV}}"
  fi
  echo "$ACCUMULATED_VENV_PROMPT"
}

function gp-keep-old-prompt() {
  if [[ -z $GIT_PROMPT_OLD_DIR_WAS_GIT ]]; then
    OLD_PROMPT=$PS1
  fi
  GIT_PROMPT_OLD_DIR_WAS_GIT=$(we_are_on_repo)
}

function gp-set-last-exit() {
  GIT_PROMPT_LAST_COMMAND_STATE=$?
}

function gp-set-prompt() {
  gp-set-last-exit
  gp-keep-old-prompt

  local repo=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ ! -e "$repo" ]] && [[ "$GIT_PROMPT_ONLY_IN_REPO" = 1 ]]; then
    # we do not permit bash-git-prompt outside git repos, so nothing to do
    PS1="$OLD_PROMPT"
    return
  fi

  local EMPTY_PROMPT
  local __GIT_STATUS_CMD

  gp-config

  if [[ ! -e "$repo" ]] || [[ "$GIT_PROMPT_DISABLE" = 1 ]]; then
    PS1="$EMPTY_PROMPT"
    return
  fi

  gp-update
}


# ------------------------
# | Installation routine |
# ------------------------

function gp-load-theme() {
  # outsource the color defs
  source "${__GIT_PROMPT_DIR}/prompt-colors.sh"
  source "${__GIT_PROMPT_DIR}/theme.sh"
}

function gp-set-dir() {
  # assume the gitstatus.sh is in the same directory as this script
  # code thanks to http://stackoverflow.com/questions/59895
  local SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    local DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  __GIT_PROMPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

function gp-install-prompt {
  OLD_PROMPT=$PS1
  OLD_PROMPT_COMMAND=$PROMPT_COMMAND
  GIT_PROMPT_OLD_DIR_WAS_GIT=$(we_are_on_repo)
  PROMPT_COMMAND='gp-set-prompt'

  gp-set-dir
  gp-load-theme
}

gp-install-prompt

# vim: shiftwidth=2
