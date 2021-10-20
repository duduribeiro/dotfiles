#!/bin/bash

if [ -L "$0" ]
then
  SCRIPTSETUP="$(readlink "$0")"
else
  SCRIPTSETUP="$0"
fi

DOTFILESDIRREL=$(dirname $SCRIPTSETUP)
cd $DOTFILESDIRREL
DOTFILESDIR=$(pwd -P)

[ $(uname -s) = "Darwin" ] && export MACOS=1 && export UNIX=1
[ $(uname -s) = "Linux" ] && export LINUX=1 && export UNIX=1


echo 'Installing Plug'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if [ -n "$CODESPACES" ]
then
  rm -rf ~/.oh-my-zsh
fi

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

mkdir -p ~/.ssh

if [ $MACOS ]
then
  VSCODE="$HOME/Library/Application Support/Code/User"

	echo "Setting up your Mac  👨‍💻"

	# Check for Homebrew and install if we don't have it
	if test ! $(which brew); then
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	echo 'Running brew bundle'
	brew bundle

  ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app
elif [ $LINUX ]
then
  VSCODE="$HOME/.config/Code/User"

  echo "Setting up your Linux / Codespaces  👨‍💻"

  if ! grep -q "root.*/bin/zsh" /etc/passwd
  then
    chsh -s /bin/zsh root
  fi

  apt-get update -y

  apt-get install -y ripgrep rcm software-properties-common curl git libfuse2 fd-find libsm6 libxext6

  # Install neovim

  curl -L -o /usr/bin/nvim https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod a+x /usr/bin/nvim

  echo 'installing asdf'

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf

  (cd ~/.asdf && git checkout "$(git describe --abbrev=0 --tags)")

fi

echo 'Installing tmux plugin manager'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo 'Syncing dotfiles'

for DOTFILE in *; do
  HOMEFILE="$HOME/.$DOTFILE"
  [ -d $DOTFILE ] && DOTFILE="$DOTFILE/"
  DIRFILE="$DOTFILESDIR/$DOTFILE"

  # Don't mess with Codespaces' default GPG/SSH setup.
  if [ -n "$CODESPACES" ]
  then
    echo $DOTFILE | egrep -q '^(gnupg|ssh|sshconfig)/' && continue
  fi

  # Don't try to install documentation/script files
  echo $DOTFILE | egrep -q '(^script/$|\.txt$|\.md$)' && continue

  echo $DOTFILE | egrep -q 'sshconfig' && ln -sv "$DIRFILE" "$HOME/.ssh/config"  && continue

  # Fixup VSCode settings path
  echo $DOTFILE | grep -q 'vscode-settings' &&
       HOMEFILE="$VSCODE/settings.json" &&
       mkdir -p "$VSCODE"

  # Remove .sh extensions
  echo $DOTFILE | grep -q '\.sh' &&
       HOMEFILE="$HOME/.$(echo $DOTFILE | sed -e 's/\.sh//')"

  if [ -L "$HOMEFILE" ] && ! [ -d $DOTFILE ]
  then
    ln -sfv "$DIRFILE" "$HOMEFILE"
  else
    rm -rv "$HOMEFILE" 2>/dev/null
    ln -sv "$DIRFILE" "$HOMEFILE"
  fi
done

HOMEDOTFILES="$HOME/.dotfiles"
if [ "$DOTFILESDIR" != "$HOMEDOTFILES" ]
then
  ln -sf "$DOTFILESDIR" "$HOMEDOTFILES"
fi

# Fix up permissions for Codespaces
if [ -n "$CODESPACES" ]
then
  chmod 700 /workspaces
fi

echo 'Installing miniplug'

curl \
  -sL --create-dirs \
  https://git.sr.ht/~yerinalexey/miniplug/blob/master/miniplug.zsh \
  -o $HOME/.local/share/miniplug.zsh

source $HOME/.local/share/miniplug.zsh

miniplug install


