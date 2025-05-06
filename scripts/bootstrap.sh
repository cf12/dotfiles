#!/bin/bash

echo "[i] Run bootstrap? (y/N)"
read -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "[i] Skipping bootstrap..."
  exit 0
fi

if [ "$(uname -s)" = "Darwin" ]; then
  echo "[i] MacOS detected, bootstrapping..."
  if ! command -v brew &> /dev/null; then
    echo "[i] Homebrew not found, downloading + installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew tap homebrew/cask-fonts
  brew install font-hack
  brew install vim neovim tmux fish kitty pinentry-mac gnupg
elif [[ -f /etc/arch-release ]]; then 
  echo "[i] Arch Linux detected, bootstrapping..."
  sudo pacman --noconfirm -Sy
  sudo pacman --noconfirm -S ttf-hack
  sudo pacman --noconfirm -S vim neovim tmux fish kitty

  chsh -s /usr/bin/fish
elif [[ -f /etc/lsb-release ]]; then
  if grep -qi "microsoft" /proc/version; then
    echo "[i] Linux (WSL) detected, bootstrapping..."
    sudo apt-get update
    sudo apt-get install -y vim neovim tmux fish
  else
    echo "[i] Linux (native) detected, bootstrapping..."
    sudo apt-get update
    sudo apt-get install -y fonts-hack-ttf
    sudo apt-get install -y vim neovim tmux fish kitty
  fi

  chsh -s /usr/bin/fish
fi

echo "[i] Running init.fish"
fish scripts/init.fish
