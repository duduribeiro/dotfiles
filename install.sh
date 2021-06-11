#!/bin/sh

SCRIPT_NAME=${1:-"install.sh"}
export NONINTERACTIVE=1
# Send all our -x output to this file for later debugging
LOG_DIR="$HOME/install.sh.logs"
mkdir -p "${LOG_DIR}"
exec 1>"${LOG_DIR}/stdout"
exec 2>"${LOG_DIR}/stderr"

set -xe
export NONINTERACTIVE=1

echo "${SCRIPT_NAME} start: $(date)"

if [ "$(uname -s)" == "Darwin" ]
then
	echo "Setting up your Mac  👨‍💻"

	# Check for Homebrew and install if we don't have it
	if test ! $(which brew); then
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	echo 'Running brew bundle'
	brew bundle
else
	if ! grep -q "root.*/bin/zsh" /etc/passwd
	then
	  chsh -s /bin/zsh root
	fi

	apt-get install -y ripgrep rcm
fi

echo 'Installing Plug'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo 'Installing oh-my-zsh'
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo 'Installing miniplug'

curl \
  -sL --create-dirs \
  https://git.sr.ht/~yerinalexey/miniplug/blob/master/miniplug.zsh \
  -o $HOME/.local/share/miniplug.zsh

echo 'Syncing dotfiles'
env RCRC=$HOME/dotfiles/rcrc rcup

miniplug install
