#!/usr/bin/env bash

SCRIPT_ROOT=$(cd "$(dirname "$0")" || exit 1; pwd)
if [ -d "$SCRIPT_ROOT/setup" ]; then
  SCRIPT_ROOT="$(dirname "${SCRIPT_ROOT}")"
fi
OS=$(${SCRIPT_ROOT}/os.sh)

# This is based on keithamus dotfiles https://github.com/keithamus/dotfiles
echo "########################################"
echo "# Running duduribeiro dotfiles installer"
echo "# \`$SCRIPT_ROOT/install.sh\`"
echo "########################################"


installScript() {
  echo "###"
  echo "# Installing $1"
  echo "###"
  sh "$SCRIPT_ROOT/$2/${3:-install}.sh"
}

if [ "$OS" = "macos" ]; then
  "$SCRIPT_ROOT/homebrew/install.sh"
  brew upgrade && brew upgrade
elif [ -f "$DIR/Debfile" ] && [ "$(which apt 2>/dev/null)" ]; then
  sudo apt update && sudo apt upgrade -y
fi

if [ "$OS" = "codespace" ]; then
  installScript "codespaces" codespaces
else
  installScript "zsh" zsh
fi

installScript "Neovim" nvim
installScript "CLI Tools" cli-tools
installScript "tmux" tmux
