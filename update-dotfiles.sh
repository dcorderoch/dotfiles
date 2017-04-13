#!/bin/sh

CURR_DIR=$PWD

REPO_DIR="$HOME/stuff/dotfiles"

if [ -d "$REPO_DIR" ]; then
    cp -r $HOME/.tmux.conf    $REPO_DIR
    cp -r $HOME/.gitconfig    $REPO_DIR
    cp -r $HOME/.bashrc       $REPO_DIR
    cp -r $HOME/.bash_aliases $REPO_DIR
    cp -r $HOME/.i3           $REPO_DIR
    cp -r $HOME/.vimrc        $REPO_DIR

    cd $REPO_DIR

    git add --all && git commit -m "update dotfiles $(date '+%F %H:%M')"

    # remember to keep ssh agent ready if using ssh
    # otherwise this will show the annoying prompt
    # for a password
    git push

    cd $CURR_DIR
else
    echo "$REPO_DIR does not exist!"
fi

unset CURR_DIR
unset REPO_DIR
