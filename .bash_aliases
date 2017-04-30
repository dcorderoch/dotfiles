# volume control aliases
alias fullvolume="pactl set-sink-volume 0 150%"
alias lowvolume="pactl set-sink-volume 0 50%"
alias mute="pactl set-sink-volume 0 0%"

# disk usage aliases
alias myusedspace='df -hal | grep -Ei "^(\/|Filesystem)" '

# open pdf and redirect output to /dev/null
openpdf() { sh -c 'which xpdf && `xpdf "$1" > /dev/null 2>&1` || `evince "$1" > /dev/null 2>&1`' & }

# misc alias
alias getdate="$HOME/stuff/scripts/getDate.sh"
function findproc { ps aux | grep -Eiv grep | grep -Ei "$1"; }

# git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '

# window manager control alias
alias windows="$HOME/stuff/scripts/windows.sh"

# check for ssh-agent identitied
alias checkssh="ssh-add -l"

# transmission cli || daemon/remote aliases
alias tdrestart="sudo /etc/init.d/transmission-daemon start"
alias tdstart="transmission-daemon -g /home/dcipher/.config/transmission"
alias tdhalt="bash $HOME/stuff/scripts/tdstop.sh"
tdclear()    { transmission-remote -l | grep 100% | awk '{print $1}' | grep -Eio '[0-9]+' | xargs -n 1 -I % transmission-remote -t % -r ;}
tdls()       { transmission-remote -l ;}
tdpause()    { transmission-remote -l | grep -v ETA | grep -v Sum | awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % --stop ;}
tdunpause()  { transmission-remote -l | grep -v ETA | grep -v Sum | awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % --start ;}
tdgetpeers() { transmission-remote -t "$1" --reannounce ;}
tdcontinue() { transmission-remote -t "$1" --start ;}

# force tmux to use 256 colors
alias tmux="tmux -2"
