#!/usr/bin/env bash

sudo apt update && sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    git

sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin

cp -rv ~/code/personal/dotfiles/nix/. ~/
cp -rv ~/code/personal/dotfiles/common/. ~/
