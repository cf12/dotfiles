# GPG SSH Setup
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Aliases
alias ll "ls -l"
alias v "nvim"
