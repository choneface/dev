#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Pushing Dev Environment"
echo "========================"

# Push scripts to /usr/local/bin
echo ""
echo "Installing scripts to /usr/local/bin..."
for script in "$SCRIPT_DIR/scripts/"*; do
    if [[ -f "$script" ]]; then
        name=$(basename "$script")
        echo "  -> $name"
        sudo cp "$script" /usr/local/bin/
        sudo chmod +x /usr/local/bin/"$name"
    fi
done

# Symlink tmux config
echo ""
echo "Linking tmux config to ~/.tmux.conf..."
if [[ -e ~/.tmux.conf ]]; then
    if [[ -L ~/.tmux.conf ]]; then
        rm ~/.tmux.conf
    else
        echo "  Backing up existing tmux config to ~/.tmux.conf.bak"
        mv ~/.tmux.conf ~/.tmux.conf.bak
    fi
fi
ln -s "$SCRIPT_DIR/tmux.conf" ~/.tmux.conf
echo "  -> Linked"

# Symlink nvim config
echo ""
echo "Linking nvim config to ~/.config/nvim..."
if [[ -e ~/.config/nvim ]]; then
    if [[ -L ~/.config/nvim ]]; then
        rm ~/.config/nvim
    else
        echo "  Backing up existing nvim config to ~/.config/nvim.bak"
        mv ~/.config/nvim ~/.config/nvim.bak
    fi
fi
ln -s "$SCRIPT_DIR/nvim" ~/.config/nvim
echo "  -> Linked"

# Add zsh config source line to ~/.zshrc if not present
echo ""
echo "Configuring zsh..."
ZSH_SOURCE_LINE="source $SCRIPT_DIR/zsh/config.zsh"
if ! grep -qF "$ZSH_SOURCE_LINE" ~/.zshrc 2>/dev/null; then
    echo "" >> ~/.zshrc
    echo "# Custom dev environment config" >> ~/.zshrc
    echo "$ZSH_SOURCE_LINE" >> ~/.zshrc
    echo "  -> Added source line to ~/.zshrc"
else
    echo "  -> Source line already present in ~/.zshrc"
fi

echo ""
echo "Done!"
