# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

export VISUAL=nvim
export EDITOR=nvim

# path configuation
PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin:$HOME/dotnet" # appending

# manually add bash to path
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# silence zsh warning on Mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# add Go to path
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH=$PATH:/opt/homebrew/bin

[[ -f ~/.bash_wd ]] && source ~/.bash_wd

eval "$(starship init bash)"
# -w logs every keystroke (builtin) for vim-habit analysis; local file only
alias v='nvim -w ~/.local/state/nvim/keys.log'
alias vi='nvim -w ~/.local/state/nvim/keys.log'
alias nv='nvim -w ~/.local/state/nvim/keys.log'
alias ..="cd .."
alias l="ls -lah"
alias cr=cresume

# set aliases
function gacp() {
  git add .
  git commit -m "$1"
  git push origin HEAD
}
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gco="git checkout"
# alias gpsup="git push --set-upstream origin $(git branch)"
alias gfa="git fetch --all --prune"

function gwa() {
  local branch="$1"
  if [[ -z "$branch" ]]; then
    echo "Usage: gwa <branch-name>"
    return 1
  fi
  local dir="../${branch//\//-}"
  git worktree add "$dir" -b "$branch" &&
    cp .env "$dir/.env" 2>/dev/null &&
    cd "$dir" &&
    direnv allow
}

alias cpbranch="git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | pbcopy"
alias cppwd="pwd | pbcopy"
alias cpip="curl ifconfig.me | pbcopy"
# attach to tmux with independent view (no mirroring)
function ta() {
  local target="${1:-main}"
  if ! tmux has-session -t "$target" 2>/dev/null; then
    tmux new-session -s "$target"
  else
    tmux new-session -t "$target"
  fi
}

function ?() {
  w3m "https://duckduckgo.com/lite?q=$(echo "$*" | sed 's/ /+/g')"
}

function ??() {
  claude -p "$*"
}
alias sb='source ~/.bashrc'
alias st='source ~/.tmux.conf'
alias eb='v ~/Projects/chad-setup/bash/.bashrc'
alias ec='v ~/.claude/CLAUDE.md'
alias da='direnv allow'

alias tf='terraform'
alias d='docker'
alias dc='docker compose'
alias ld='lazydocker'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

eval "$(direnv hook bash)"
eval "$(zoxide init bash)"

# manually export LANG such that blesh does not complain
# export LANG=en_US.UTF-8
# export LANGUAGE=en
# source ~/.local/share/blesh/ble.sh

# restore terminal echo after aborted programs (e.g. uvicorn --reload)
PROMPT_COMMAND="stty sane; $PROMPT_COMMAND"
