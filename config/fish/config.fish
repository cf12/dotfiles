# GPG SSH Setup
gpgconf --launch gpg-agent

set -e SSH_AGENT_PID
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_TTY (tty)

# Aliases
alias ll "ls -l"
alias v "nvim"

# Pywal
cat ~/.cache/wal/sequences &
