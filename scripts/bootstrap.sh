#!/bin/bash

if [ "$(uname -s)" == "Darwin" ]; then
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew install vim neovim tmux fish kitty pinentry-mac gnupg
elif [[ -f /etc/arch-release ]]; then 
  sudo pacman --noconfirm -Sy
  sudo pacman --noconfirm -S ttf-hack
  sudo pacman --noconfirm -S vim neovim tmux fish kitty

  chsh -s /usr/bin/fish
fi