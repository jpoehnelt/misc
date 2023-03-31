tmp_path=./tmp
mkdir -p "$tmp_path"

download_file() {
  if command -v curl >/dev/null 2>&1; then
    curl "$1" --output "$tmp_path/$2"
  elif command -v wget >/dev/null 2>&1; then
    wget "$1" -O "$tmp_path/$2"
  else
    printf "%s\n" "curl/wget not available - download manually from the repo link, quitting."
    exit 1
  fi
}

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

if ! [ -d ~/.oh-my-zsh ]; then
  echo "Dependency [oh-my-zsh] missing, downloading"
  run_remote_file "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
fi

download_file "https://raw.githubusercontent.com/Zekihan/misc/main/.zshrc" .zshrc
mv "$tmp_path/.zshrc" ~/.zshrc

rm -rf "$tmp_path"
