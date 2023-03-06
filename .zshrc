# Set up the prompt

autoload -Uz promptinit
promptinit

PROMPT='%F{red}%n%f%F{cyan}@%f%F{yellow}%m%f%F{orange}:%1~%f%F{blue}$ %f'

unsetopt EXTENDED_HISTORY
setopt histignorealldups sharehistory append_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

bindkey -v

bindkey -M viins "^[." insert-last-word

export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Use modern completion system
autoload -Uz compinit; compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

export HISTFILE=~/.zsh_history

bindkey "^R" backward-kill-word # control + backspace

bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

setopt NO_HUP
setopt NO_CHECK_JOBS

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

alias reload='source $HOME/.zshrc'

[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# this is a fix for the autosuggestions that don't show in a solarized dark theme on the shell
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

enable_ibus() {
  export GTK_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT_IM_MODULE=ibus
}

command -v ibus-daemon > /dev/null && enable_ibus

man() {
  env \
  LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
  LESS_TERMCAP_md="$(printf "\e[1;31m")" \
  LESS_TERMCAP_me="$(printf "\e[0m")" \
  LESS_TERMCAP_se="$(printf "\e[0m")" \
  LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
  LESS_TERMCAP_ue="$(printf "\e[0m")" \
  LESS_TERMCAP_us="$(printf "\e[1;32m")" \
  man "${@}"
}

HAVE_TASK=0
command -v task > /dev/null && HAVE_TASK=1
if [ "${HAVE_TASK}" = "1" ]; then
  task
  alias ta='task'
  alias taa='task add'
  alias tal='task calendar'
  fi
unset HAVE_TASK

HAVE_MUTT=0
command -v neomutt > /dev/null && HAVE_MUTT=1
if [ "${HAVE_MUTT}" = "1" ]; then
  alias mutt='neomutt'
fi
unset HAVE_MUTT

HAVE_EXA=0
command -v exa > /dev/null && HAVE_EXA=1
if [ "${HAVE_EXA}" = "1" ]; then
  alias ls='exa'
  alias lst='exa --sort old'
  alias tree='exa -T'
fi
unset HAVE_EXA

ssh-add -l &>/dev/null
if [ "$?" = 2 ]; then
  test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null
  ssh-add -l &>/dev/null
  if [ "$?" = 2 ]; then
    (umask 066; ssh-agent > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    ssh-add
  fi
fi

[ -d "$HOME/dev/sw/android" ] && alias sdkmanager="$HOME/dev/sw/android/tools/bin/sdkmanager --sdk_root=$HOME/dev/sw/android"
[ -d "/usr/local/go" ] && export PATH="/usr/local/go/bin:$PATH"
[ -f /usr/share/nvm/init-nvm.sh ] && . /usr/share/nvm/init-nvm.sh

[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

[ -f ~/.sh_aliases ] && . ~/.sh_aliases
[ -f ~/.workrc ] && . ~/.workrc

export BROWSER=firefox
