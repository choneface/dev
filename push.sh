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

echo ""
echo "Done!"
