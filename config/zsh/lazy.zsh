# Emacs mode
bindkey -e

# Disable accept-line-and-down-history
bindkey -r "^O"

# Editor
export EDITOR=nvim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
# export GIT_EDITOR="${EDITOR}"

# Less
export PAGER=less
export LESS='-R -f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'
[ ! -d "$XDG_STATE_HOME/less" ] && mkdir -p "$XDG_STATE_HOME/less"
export LESSHISTFILE="$XDG_STATE_HOME"/less/history

# LESS man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;44;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# ls command colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# fzf - command-line fuzzy finder (https://github.com/junegunn/fzf)
export FZF_DEFAULT_OPTS="--extended --ansi --multi"

# Ruby
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
eval "$(rbenv init - --no-rehash zsh)"
if type brew > /dev/null; then
  export LIBRARY_PATH="${LIBRARY_PATH:+$LIBRARY_PATH:}$(brew --prefix zstd)/lib/"
fi

# Atuin - shell history sync
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# git-wt - git worktree helper
if type git-wt > /dev/null 2>&1; then
  eval "$(git wt --init zsh)"
fi

# ghq
## ghqとの連携。ghqの管理下にあるリポジトリを一覧表示する。ctrl - ]にバインド。
function peco-src () {
  local selected_dir=$(ghq list | peco --prompt="repositories >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    local ghq_root=$(ghq root)
    BUFFER="cd ${ghq_root}/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# wt - interactive worktree selection with peco
function wt () {
  local selected=$(git wt | tail -n +2 | peco --prompt="worktrees >" | awk '{print $(NF-1)}')
  if [ -n "$selected" ]; then
    git wt "$selected"
  fi
}

sheldon::load lazy
