# complete system update alias command
#alias sysupdate='$HOME/stuff/scripts/update.sh; $HOME/stuff/scripts/pupdate.sh;$HOME/stuff/scripts/rmconfigfiles.sh'

alias checkssh="ssh-add -l"

# transmission cli || daemon/remote aliases
alias tdrestart="sudo /etc/init.d/transmission-daemon start"
alias tdstart="transmission-daemon -g /home/dcipher/.config/transmission"
alias tdstop="bash $HOME/stuff/scripts/tdstop.sh"
tdclear()    { transmission-remote -l | grep 100% | awk '{print $1}' | grep -Eio '[0-9]+' | xargs -n 1 -I % transmission-remote -t % -r ;}
tdls()       { transmission-remote -l ;}
tdpause()    { transmission-remote -l | grep -v ETA | grep -v Sum | awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % --stop ;}
tdunpause()  { transmission-remote -l | grep -v ETA | grep -v Sum | awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % --start ;}
tdgetpeers() { transmission-remote -t "$1" --reannounce ;}
tdseed()     { for i in $(transmission-remote -l | grep 100% | awk '{print }'); do transmission-remote -t $i --start; done ;}
tdcontinue() { transmission-remote -t "$1" --start ;}

# misc alias getdate=$HOME/stuff/scripts/getDate.sh
alias journalEntry="$HOME/stuff/scripts/journalEntry.sh"
alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'
alias hibernate='sudo pm-hibernate'

# open-pdf alias
openpdf() { which xpdf && `xpdf "$1" > /dev/null 2>&1` || `evince "$1" > /dev/null 2>&1` & }

# git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

function micro { lxterminal -e "micro $1"; }
alias umlet="bash /home/dcipher/.local/bin/Umlet/umlet.sh"

# window manager control alias
alias windows="$HOME/stuff/scripts/windows.sh"

# mplayer aliases
#alias mplayer2='mplayer2 -use-filename-title '
#alias mplayer='mplayer -use-filename-title '

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
function findproc { ps aux | grep -Eiv grep | grep -Ei "$1"; }
function sch2net { name=$(echo $1 | sed s/\.sch//g); gnetlist -g spice -o "$name".net $1; }
function net2results { raw=$(cat $1 | grep -Eiv "^(\.|\*)"); components=$(echo $raw | grep -Eio "(R|V).{1,2}"); voltages=$(for i in $components; do echo -n "v($i) ";done;echo -e "\n"); currents=$(for i in $components; do echo -n "i($i) ";done;echo -e "\n"); perl -pi -e 's/^\.END//g' $1; echo ".opt numdgt=10" >> $1; echo ".list" >> $1; echo ".print dc $voltages" >> $1; echo ".dc" >> $1; echo ".print dc $currents" >> $1; echo ".dc" >> $1; echo ".end" >> $1; }
alias tg='/home/dcipher/code/tg/bin/telegram-cli -N'
alias espe="cd /data/odrive/Estudiantec/TEC/2016-II/Software_Specification_and_Design/"
del() { trash "$1"; }
alias fullvolume="pactl set-sink-volume 1 150%"
alias lowvolume="pactl set-sink-volume 1 50%"
alias mute="pactl set-sink-volume 0%"
alias operativos="cd /data/odrive/Estudiantec/TEC/2017-I/OS"
alias myusedspace='df -hal | grep -E "Filesystem|home|data|\/$"'
alias pernix="cd ~/code/pernix"
alias machine="virtualbox --startvm ugnome --fullscreen > /dev/null 2>&1 &"
