#!/bin/sh

date >> ~/dotfiles_status
echo "(dotfiles) starting ..." >> ~/dotfiles_status

if [ "$(uname -s)" == "Darwin" ]
then
	echo "Setting up your Mac  👨‍💻"

	# Check for Homebrew and install if we don't have it
	if test ! $(which brew); then
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	echo 'Running brew bundle'
	brew bundle
fi

echo 'Installing Plug'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo 'Installing oh-my-zsh'
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo 'Installing zinit'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

echo 'Syncing dotfiles'
env RCRC=$HOME/dotfiles/rcrc rcup
