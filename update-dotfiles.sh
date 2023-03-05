#!/usr/bin/env sh

update_dotfiles() {
  git commit -m "update dotfiles $(date '+%F %H:%M')"
}

update_dotfiles
