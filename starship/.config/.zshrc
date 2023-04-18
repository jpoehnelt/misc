eval "$(starship init zsh)"
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nano"

source "$HOME/repos/misc/deps/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/repos/misc/deps/.zsh/ohmyzsh/plugins/sudo/sudo.plugin.zsh"
source "$HOME/repos/misc/deps/.zsh/zsh-autopair/autopair.zsh"
autopair-init
source "$HOME/repos/misc/deps/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if command -v kubectl > /dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

path+=("$HOME/docker-compose/scripts")
path+=("$HOME/wg_mesh/scripts")
export PATH

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias free='free -m'

alias compose='doppler run -- docker compose '
alias tf='doppler run --name-transformer tf-var -- terraform '
alias chmodssh='chmod 700 ~/.ssh && chmod 600 ~/.ssh/* && chmod 644 ~/.ssh/*.pub'
alias m="git checkout main"

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
