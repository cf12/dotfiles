# GPG SSH Setup
gpgconf --launch gpg-agent

set -e SSH_AGENT_PID
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_TTY (tty)

# Aliases
alias ll "ls -l"

set -g theme_display_git_default_branch yes
set -g theme_title_display_process yes
set -g theme_display_user yes
set -g theme_display_sudo_user yes
set -g theme_color_scheme base16-dark

function fish_right_prompt; end

function fish_greeting
    if command -sq neofetch
        neofetch \
        --disable packages cpu gpu \
        --color_blocks off
    end
end
