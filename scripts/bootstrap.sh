#!/usr/bin/env bash

set -euo pipefail

IFS=" "

# Common packages
COMMON_PACKAGES="vim neovim tmux zsh"
WSL_PACKAGES="$COMMON_PACKAGES"
APT_PACKAGES="$COMMON_PACKAGES fonts-hack-ttf kitty"
MACOS_PACKAGES="$COMMON_PACKAGES font-hack kitty pinentry-mac gnupg"
ARCH_PACKAGES="$COMMON_PACKAGES ttf-hack kitty"
FISH_PACKAGES="jorgebucaran/fisher \
               jorgebucaran/autopair.fish \
               IlanCosman/tide@v6 \
               PatrickF1/fzf.fish"

log() {
    echo "[i] $1"
}

prompt() {
    echo -n "[?] $1 (y/N) "
    read -r

    [[ $REPLY =~ ^[Yy]$ ]]
}

install_macos() {
    # Bootstrap brew if not installed
    log "MacOS detected, bootstrapping..."
    if ! command -v brew &> /dev/null; then
        log "Homebrew not found, downloading + installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew tap homebrew/cask-fonts
    brew install $MACOS_PACKAGES
}

install_arch() {
    log "Arch Linux detected, bootstrapping..."
    sudo pacman --noconfirm -Sy
    sudo pacman --noconfirm -S $ARCH_PACKAGES
}

install_linux() {
    if grep -qi "microsoft" /proc/version; then
        log "Linux (WSL) detected, bootstrapping..."
        sudo apt-get update
        sudo apt-get install -y $WSL_PACKAGES
    else
        log "Linux (native) detected, bootstrapping..."
        sudo apt-get update
        sudo apt-get install -y $APT_PACKAGES
    fi
}

# Change shell to zsh
# change_shell() {
#     if ! prompt "Change default shell to zsh?"; then
#         log "Skipping shell change..."
#         return
#     fi

#     # Change default shell to zsh
#     if [[ "$SHELL" != *"zsh"* ]]; then
#         log "Changing default shell to zsh..."
#         chsh -s "$(command -v zsh)"
#     fi
# }

# Change shell to fish
change_shell() {
    if ! prompt "Change default shell to fish?"; then
        log "Skipping shell change..."
        return
    fi

    # Change default shell to fish
    if [[ "$SHELL" != *"fish"* ]]; then
        log "Changing default shell to fish..."
        chsh -s "$(command -v fish)"
    fi

    log "Installing fisher + packages"
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source"
    fish -c "fisher install $FISH_PACKAGES"
}

bootstrap() {
    if ! prompt "Run bootstrap?"; then
        log "Skipping bootstrap..."
        return
    fi

    if [ "$(uname -s)" = "Darwin" ]; then
        log "MacOS detected, installing brew packages..."
        install_macos
    elif [ -f /etc/arch-release ]; then
        log "Arch Linux detected, installing pacman packages..."
        install_arch
    elif [ -f /etc/lsb-release ]; then
        log "Linux (native) detected, installing apt packages..."
        install_linux
    else
        log "Unsupported Linux distribution"
        exit 1
    fi
}

bootstrap
change_shell