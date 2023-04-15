#!/bin/bash

home=$HOME

if ! command -v zsh >/dev/null 2>&1; then
  echo "Dependency [zsh] missing, downloading"
  sudo apt install zsh
fi

if ! command -v starship >/dev/null 2>&1; then
  echo "Dependency [starship] missing, downloading"
  curl -LsS https://starship.rs/install.sh | sudo sh -s -- -y
fi

if [ ! -d "$home/repos/misc" ]; then
  mkdir -p "$home/repos"
  cd "$home/repos" || exit
  git clone https://github.com/Zekihan/misc.git
  cd - || exit
  cd "$home/repos/misc" || exit
  git submodule update --init --recursive
  cd - || exit
fi

cd "$home/repos/misc" || exit
git pull --rebase --autostash --recurse-submodules
cd - || exit

cd "$home/repos/misc/starship/scripts" || exit
bash configure.sh
cd - || exit
