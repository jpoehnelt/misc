#!/bin/bash

home=$HOME

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

cd "$home/repos/misc/motd/scripts" || exit
bash configure.sh
cd - || exit
