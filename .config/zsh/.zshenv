export DOTS="$HOME/Repositories/dotfiles"
export REPOS="$HOME/Repositories"
export XDG_CACHE_HOME="$HOME/Library/Caches"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# --- [[ ZSH ]] ---
[[ ! -d "$ZDOTDIR/.zfunc" ]] && mkdir "$ZDOTDIR/.zfunc"
fpath+="$ZDOTDIR/.zfunc"