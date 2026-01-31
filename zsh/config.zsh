# Custom zsh configuration
# This file is sourced from ~/.zshrc

# Quick cd to repos
f() {
    if [ -z "$1" ]; then
        echo "Must provide a repository name"
        return 1
    fi
    cd ~/Desktop/repos/$1
}

bindkey -s '^f' 'tmux-sessionizer\n'
