if [[ -x /opt/homebrew/bin/brew ]]; then
	export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

autoload -Uz compinit
compinit

if [[ $(command -v n) >/dev/null ]];then
	export N_PREFIX="$XDG_CACHE_HOME/n"
	export PATH="$N_PREFIX/bin:$PATH"
fi

# --- [[ OCaml ]] ---
if [[ $(command -v pyenv) >/dev/null ]]; then
	export OPAMROOT="$XDG_CACHE_HOME/opam"
	eval "$(opam env)"
fi

# --- [[ Python ]] ---
if [[ $(command -v pyenv) >/dev/null ]]; then
	export PYENV_ROOT="$XDG_CACHE_HOME/pyenv"
	[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init - zsh)"
fi

# --- [[ Rust ]] ---
export RUSTUP_HOME="$XDG_CACHE_HOME/rustup"
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

if [[ -e "$CARGO_HOME/env" ]]; then
	. "$CARGO_HOME/env"

	[[ ! -e "$ZDOTDIR/.zfunc/_rustup" ]] && \
		rustup completions zsh rustup > $ZDOTDIR/.zfunc/_rustup
	[[ ! -e "$ZDOTDIR/.zfunc" ]] && \
		rustup completions zsh cargo > $ZDOTDIR/.zfunc/_cargo
fi

# --- [[ Scripts ]] ---
export PATH="$PATH:$HOME/.local/bin/"

# --- [[ Theming ]] ---
autoload -U promptinit; promptinit
prompt typewritten

# --- [[ Aliases ]] ---
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -la"
