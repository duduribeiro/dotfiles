#!/bin/bash
set -eo pipefail

if [ ! -d ~/.tmux/plugins/tpm ]; then
  # Install tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
