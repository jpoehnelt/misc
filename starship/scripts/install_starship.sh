#!/bin/bash

run_remote_file() {
  if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL "$1")"
  elif command -v wget >/dev/null 2>&1; then
    sh -c "$(wget "$1" -O -)"
  else
    printf "%s\n" "curl/wget not available - download manually from the repo link, quitting."
    exit 1
  fi
}

if ! command -v zsh >/dev/null 2>&1; then
  echo "Dependency [zsh] missing, downloading"
  sudo apt install zsh
fi

if ! command -v starship >/dev/null 2>&1; then
  echo "Dependency [starship] missing, downloading"
  run_remote_file "https://starship.rs/install.sh"
fi

if [ ! -d "$HOME/repos/misc" ]; then
  mkdir -p "$HOME/repos"
  cd "$HOME/repos" || exit
  git clone https://github.com/Zekihan/misc.git
  cd - || exit
  cd "$HOME/repos/misc" || exit
  git submodule update --init --recursive
  cd - || exit
fi

cd "$HOME/repos/misc" || exit
git pull --rebase --autostash --recurse-submodules
cd - || exit

if [[ "$SHELL" == *bash* ]]; then
  ln -fs "$HOME/repos/misc/starship/.config/.bashrc" "$HOME/.bashrc"
elif [[ "$SHELL" == *zsh* ]]; then
  ln -fs "$HOME/repos/misc/starship/.config/.zshrc" "$HOME/.zshrc"
else
  echo "Unknown shell"
fi

mkdir -p "$HOME/.config/"
ln -fs "$HOME/repos/misc/starship/.config/starship.toml" "$HOME/.config/starship.toml"
