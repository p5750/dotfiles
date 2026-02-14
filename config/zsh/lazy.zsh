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

# === First-time setup (runs only once if not configured) ===

# git-wt - install if not present
if ! type git-wt > /dev/null 2>&1; then
  if type go > /dev/null 2>&1; then
    echo "Installing git-wt..."
    go install github.com/k1LoW/git-wt@latest
  fi
fi

# Node.js - install via volta if not present
if ! type node > /dev/null 2>&1; then
  if type volta > /dev/null 2>&1; then
    echo "Installing Node.js via volta..."
    volta install node
  else
    echo "Error: volta is not installed. Please run 'brew install volta' first." >&2
  fi
fi

# Playwright CLI - install via volta if not present
if ! type playwright-cli > /dev/null 2>&1; then
  if type volta > /dev/null 2>&1 && type node > /dev/null 2>&1; then
    echo "Installing Playwright CLI..."
    volta install @playwright/cli@latest
  fi
fi

# Claude Code skills - install if not present
if type npx > /dev/null 2>&1; then
  local skills_dir="${HOME}/.claude/skills"
  if [[ ! -d "$skills_dir/vercel-react-best-practices" ]]; then
    echo "Installing Claude Code skills..."
    npx add-skill vercel-labs/agent-skills -a claude-code -g -s vercel-react-best-practices -y
    npx add-skill vercel-labs/agent-skills -a claude-code -g -s web-design-guidelines -y
  fi
fi

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
