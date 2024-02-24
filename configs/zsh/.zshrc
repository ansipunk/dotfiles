HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt extendedglob notify
unsetopt autocd beep nomatch
bindkey -e

export TERM=screen-256color

alias "v=nvim"
alias "ls=ls --color=auto"
alias "grep=grep --color=auto"
alias "info=info --vi-keys"

command -v starship > /dev/null && eval "$(starship init zsh)"
command -v bun > /dev/null && source "$HOME/.bun/_bun"

export PYTEST_PROC_NUM=16

mkdir -p ~/.zfunc
fpath+=~/.zfunc
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit

$(command -v poetry) completions zsh > ~/.zfunc/_poetry
$(command -v deno) completions zsh > ~/.zfunc/_deno

autoload -U bashcompinit
bashcompinit

command -v pipx > /dev/null && eval "$(register-python-argcomplete pipx)"

source ~/.scripts/db.zsh
source ~/.scripts/utils.zsh
