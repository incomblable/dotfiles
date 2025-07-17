if [[ -x /opt/homebrew/bin/brew ]]; then
	export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

autoload -Uz compinit
compinit

# --- [[ VSCode ]] ---
if command -v codium &>/dev/null || command -v code &>/dev/null ; then
	[[ $(defaults read com.vscodium ApplePressAndHoldEnabled) != 0 ]] &&
		defaults write com.vscodium ApplePressAndHoldEnabled -bool false
fi

# --- [[ Go ]] ---
export GOPATH="$XDG_CACHE_HOME/go"
export PATH="$GOPATH/bin:$PATH"

# --- [[ Scripts ]] ---
export PATH="$PATH:$HOME/.local/bin"

# --- [[ Theming ]] ---
autoload -U promptinit
promptinit
prompt typewritten

# --- [[ Aliases ]] ---
alias code="codium"
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -la"
