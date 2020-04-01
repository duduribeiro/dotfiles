#!/bin/sh

echo "Setting up your Mac  👨‍💻"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check for homeshick and install if we don't have it
if [ -f $HOME/.homesick/repos/homeshick ]; then
  echo 'installing homeshick...'
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.zshrc
  source $HOME/.zshrc
  $HOME/.homesick/repos/homeshick/bin/homeshick clone duduribeiro/dotfiles
fi


$HOME/.homesick/repos/homeshick/bin/homeshick pull

# Update Homebrew recipes
echo 'updating brew...'
brew update

# Installing dependencies from Brewfile
echo 'installing dependencies from Brewfile...'
brew bundle --file $HOME/.Brewfile

echo 'Setup finished!'
