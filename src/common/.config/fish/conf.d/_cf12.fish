# GPG SSH Setup
gpgconf --launch gpg-agent

set -e SSH_AGENT_PID
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_AGENT_INFO (gpgconf --list-dirs agent-socket):0:1
set -x GPG_TTY (tty)

# Aliases
alias ll "ls -l"
alias python python3

# Custom functions
function git_convert_remote -d "git_convert_ssh <remote>"
    set -l remote (git remote get-url $argv[1])
    set -l remote_stripped (echo $remote | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://')
    set -l url

    switch $remote
    case 'https://*'
        echo "Converting remote $argv[1] to SSH"
        set url "git@github.com:$remote_stripped"
    case 'git@github.com:*'
        echo "Converting remote $argv[1] to HTTPS"
        set url "https://github.com/$remote_stripped"
    case '*'
        return 1
    end

    git remote set-url $argv[1] $url
end

# Custom theme settings
set -g theme_display_git_default_branch yes
set -g theme_title_display_process yes
set -g theme_display_user yes
set -g theme_display_sudo_user yes
set -g theme_color_scheme base16-dark
set -g theme_display_date no
# set -g theme_date_format "+%H:%M %p"

# Custom prompt / greeting
# function fish_right_prompt; end
function fish_greeting; end

# Paths
set -gx PATH "$HOME/.local/bin" $PATH