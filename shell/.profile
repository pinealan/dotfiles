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

# execute local machine-specific .profile if it exists
local_profile="$HOME/.local/profile"
[ -f  $local_profile ] && . $local_profile
