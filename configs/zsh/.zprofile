export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config

export PATH=$PATH:$HOME/.local/bin

export BUN_INSTALL=$HOME/.bun
export CARGO_INSTALL=$HOME/.cargo
export DENO_INSTALL=$HOME/.deno
export GOPATH=$HOME/Go
export NPM_PACKAGES=$HOME/.npm-packages

export PATH=$PATH:$BUN_INSTALL/bin
export PATH=$PATH:$CARGO_INSTALL/bin
export PATH=$PATH:$DENO_INSTALL/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$NPM_PACKAGES/bin

export MANPATH=${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export MOZ_ENABLE_WAYLAND=1
fi
