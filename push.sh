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

echo ""
echo "Done!"
