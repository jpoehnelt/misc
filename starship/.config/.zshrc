eval "$(starship init zsh)"
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nano"

bindkey '^ ' autosuggest-accept

source "$HOME/repos/misc/deps/.zsh/ohmyzsh/plugins/sudo/sudo.plugin.zsh"
source "$HOME/repos/misc/deps/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/repos/misc/deps/.zsh/zsh-autopair/autopair.zsh"
autopair-init
source "$HOME/repos/misc/deps/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

path+=("$HOME/docker-compose/scripts")
path+=("$HOME/wg_mesh/scripts")
export PATH

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias free='free -m'

alias compose='doppler run -- docker compose '
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
