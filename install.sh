#!/bin/sh

SCRIPT_NAME=${1:-"setup"}
export NONINTERACTIVE=1
# Send all our -x output to this file for later debugging
LOG_DIR="$HOME/setup.logs"
mkdir -p "${LOG_DIR}"
exec 1>"${LOG_DIR}/stdout"
exec 2>"${LOG_DIR}/stderr"

set -xe
export NONINTERACTIVE=1

echo "${SCRIPT_NAME} start: $(date)"

if [ -L "$0" ]
then
  SCRIPTSETUP="$(readlink "$0")"
else
  SCRIPTSETUP="$0"
fi

echo $SCRIPTSETUP
DOTFILESDIRREL=$(dirname $SCRIPTSETUP)
cd $DOTFILESDIRREL/..
DOTFILESDIR=$(pwd -P)

[ $(uname -s) = "Darwin" ] && export MACOS=1 && export UNIX=1
[ $(uname -s) = "Linux" ] && export LINUX=1 && export UNIX=1


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
elif [ $LINUX ]
then
  VSCODE="$HOME/.config/Code/User"

  echo "Setting up your Linux / Codespaces  👨‍💻"

  if ! grep -q "root.*/bin/zsh" /etc/passwd
  then
    chsh -s /bin/zsh root
  fi

  apt-get install -y ripgrep rcm
fi

echo 'Syncing dotfiles'

for DOTFILE in *; do
  HOMEFILE="$HOME/.$DOTFILE"
  [ -d $DOTFILE ] && DOTFILE="$DOTFILE/"
  DIRFILE="$DOTFILESDIR/$DOTFILE"

  # Don't mess with Codespaces' default GPG/SSH setup.
  if [ -n "$CODESPACES" ]
  then
    echo $DOTFILE | egrep -q '^(gnupg|ssh)/' && continue
  fi

  # Don't try to install documentation/script files
  echo $DOTFILE | egrep -q '(^script/$|\.txt$|\.md$)' && continue

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


echo 'Installing Plug'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# echo 'Installing oh-my-zsh'
# #sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo 'Installing miniplug'

curl \
  -sL --create-dirs \
  https://git.sr.ht/~yerinalexey/miniplug/blob/master/miniplug.zsh \
  -o $HOME/.local/share/miniplug.zsh

source $HOME/.local/share/miniplug.zsh

miniplug install


