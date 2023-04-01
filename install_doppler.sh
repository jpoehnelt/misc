if ! command -v doppler >/dev/null 2>&1; then
  echo "Dependency [doppler] missing, downloading"
  (curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh
fi
if ! test -f "$HOME/.doppler/.doppler.yaml"; then
  doppler login -y
elif ! grep -q "token" "$HOME/.doppler/.doppler.yaml"; then
  doppler login -y
fi
