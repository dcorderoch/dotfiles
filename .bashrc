# Source global definitions
if [ -f /etc/bash.bashrc ]; then
        . /etc/bash.bashrc
fi


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s cmdhist

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If this is an xterm set the title to user@host:dir

# old PS1: "\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
# root PS1: "\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\]"

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export HISTFILESIZE=10000
export HISTSIZE=10000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -n; history -w; history -c; history -r"
export HH_CONFIG=hicolor         # get more colors
export HISTIGNORE="[ ]*:exit:cd:ls:bg:fg:history:!(+(*\ *))"
if [[ $- =~ .*i.* ]]; then bind '"\C-h": "\C-a hh \C-j"'; fi

# keychain thing
source $HOME/.keychain/$HOSTNAME-sh

export GTK_IM_MODULE=ibus
 
export XMODIFIERS=@im=ibus
 
export QT_IM_MODULE=ibus

export PATH="/home/dcipher/code/os/chrono-paper/PintOS/src/utils:$PATH"
export PATH="/home/dcipher/.local/bin/Telegram:$PATH"
