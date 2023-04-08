export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder
HIST_STAMPS="dd/mm/yyyy"
plugins=(git sudo kubectl)
source $ZSH/oh-my-zsh.sh
path+=("$HOME/docker-compose/scripts")
path+=("$HOME/wg_mesh/scripts")
export PATH
alias compose='doppler run -- docker compose '
