#!/bin/bash

home=$HOME

if command -v bash >/dev/null 2>&1; then
  ln -fs "$home/repos/misc/starship/.config/.bashrc" "$home/.bashrc"
fi
if command -v zsh >/dev/null 2>&1; then
  ln -fs "$home/repos/misc/starship/.config/.zshrc" "$home/.zshrc"
fi

mkdir -p "$home/.config/"
ln -fs "$home/repos/misc/starship/.config/starship.toml" "$home/.config/starship.toml"

