# paths
typeset -gU PATH path
typeset -gU FPATH fpath

path=(
  '/usr/local/bin'(N-/)
  '/usr/local/sbin'(N-/)
  '/usr/bin'
  '/usr/sbin'
  '/bin'
  '/sbin'
  "$path[@]"
)

if type brew > /dev/null; then
  path=(
    "$(brew --prefix)/bin"(N-/)
    "$(brew --prefix)/sbin"(N-/)
    "$path[@]"
  )
fi

path=(
  "$HOME/.pyenv/shims"(N-/)
  "$GOPATH/bin"(N-/)
  "$VOLTA_HOME/bin"(N-)
  "$CARGO_HOME/bin"(N-/)
  "$HOME/.local/bin"(N-/)
  "$path[@]"
)

fpath=(
  "$XDG_DATA_HOME/zsh/completions"(N-)
  "$fpath[@]"
)

export CLICOLOR=1

# Change directory without `cd`
setopt auto_cd

# auto-complete environment variables
setopt AUTO_PARAM_KEYS

# History file and its size
# See `man zshoptions` for more details.
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=1000000
setopt hist_ignore_all_dups
setopt share_history

setopt auto_pushd

# https://zenn.dev/fuzmare/articles/zsh-source-zcompile-all
source() {
    local input="$1"
    local cache="$input.zwc"
    if [[ ! -f "$cache" || "$input" -nt "$cache" ]]; then
        zcompile "$input"
    fi
    \builtin source "$@"
}

# initialize completions directory
[ ! -d "$XDG_CACHE_HOME/zsh" ] && mkdir -p "$XDG_CACHE_HOME/zsh"

# starship.rs
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# Volta
[ ! -f "$XDG_DATA_HOME/zsh/completions/_volta" ] && volta completions zsh -f -o "$XDG_DATA_HOME/zsh/completions/_volta"

# sheldon
# https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache
sheldon::load() {
    local profile="$1"
    local plugins_file="$SHELDON_CONFIG_DIR/plugins.toml"
    local cache_file="$XDG_CACHE_HOME/sheldon/$profile.zsh"
    if [[ ! -f "$cache_file" || "$plugins_file" -nt "$cache_file" ]]; then
        mkdir -p "$XDG_CACHE_HOME/sheldon"
        sheldon --profile="$profile" source >"$cache_file"
        zcompile "$cache_file"
    fi
    \builtin source "$cache_file"
}

[ -f "$XDG_CONFIG_HOME/zsh/.zshrc-private" ] && source "$XDG_CONFIG_HOME/zsh/.zshrc-private"
[ -f "$XDG_CONFIG_HOME/zsh/.zshrc.local" ] && source "$XDG_CONFIG_HOME/zsh/.zshrc.local"

sheldon::load eager
