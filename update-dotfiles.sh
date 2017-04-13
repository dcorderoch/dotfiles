#!/bin/sh

CURR_DIR=$PWD

REPO_DIR="$HOME/stuff/dotfiles"
SCRIPT_DIR="$HOME/stuff/scripts/update-dotfiles.sh"

if [ -d "$REPO_DIR" ]; then
    cp -r $HOME/.tmux.conf    $REPO_DIR
    cp -r $HOME/.gitconfig    $REPO_DIR
    cp -r $HOME/.bashrc       $REPO_DIR
    cp -r $HOME/.bash_aliases $REPO_DIR
    cp -r $HOME/.i3           $REPO_DIR
    cp -r $HOME/.vimrc        $REPO_DIR

    cd $REPO_DIR

    diff $SCRIPT_DIR update-dotfiles.sh
    ret=$?
    if [ $ret -ne 0 ]; then
      cp -r $SCRIPT_DIR update-dotfiles.sh
    fi
    unset ret

    git add --all && git commit -m "update dotfiles $(date '+%F %H:%M')"

    git push

    cd $CURR_DIR
else
    echo "$REPO_DIR does not exist!"
fi

unset SCRIPT_DIR
unset CURR_DIR
unset REPO_DIR
