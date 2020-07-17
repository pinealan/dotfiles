# prepend PATH with user's home bin directories
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# execute local machine-specific .profile if it exists
[ -f "$HOME/.local/.profile" ] && . "$HOME/.local/.profile"
