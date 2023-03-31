tmp_path=./tmp
mkdir -p "$tmp_path"

case "$(uname --machine)" in
x86_64 | amd64) architecture="amd64" ;;
arm64 | aarch64) architecture="arm64" ;;
*)
  echo "Architecture not supported, exiting."
  exit 1
  ;;
esac

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

download_file "https://github.com/regclient/regclient/releases/latest/download/regctl-linux-$architecture" regctl
sudo mv "$tmp_path/regctl" "/usr/local/bin/regctl"
chmod +x "/usr/local/bin/regctl"

download_file "https://raw.githubusercontent.com/mag37/dockcheck/main/dockcheck.sh" dockcheck
sudo mv "$tmp_path/dockcheck" "/usr/local/bin/dockcheck"
chmod +x "/usr/local/bin/dockcheck"

rm -rf "$tmp_path"
