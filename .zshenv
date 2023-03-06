# Keep 1000 lines of history within the shell and save it to ~/.zhistory:
export HISTFILE="${ZDOTDIR}/.zhistory"
export HISTSIZE=100000
export SAVEHIST=100000

export EDITOR=vim

export KEYTIMEOUT=1
[ -d "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
