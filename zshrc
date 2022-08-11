# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FPATH=~/.zsh/functions/:$FPATH

fpath=(~/.zsh/functions $fpath);
autoload -U $fpath[1]/*(.:t)

setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

export ERL_AFLAGS="-kernel shell_history enabled"
export PATH=~/.dotfiles/bin/:~/.local/bin/:$PATH

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# Load asdf. for mac it is the first option and the second for codespaces
[[ ! -f /usr/local/opt/asdf/libexec/asdf.sh ]] || source /usr/local/opt/asdf/libexec/asdf.sh
[[ ! -f ~/.asdf/asdf.sh ]] || source ~/.asdf/asdf.sh

# aliases
alias ls="ls -G"
alias ll="ls -lG"
[[ ! -f ~/.aliases ]] || source ~/.aliases

export PKG_CONFIG_PATH="$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix krb5)/lib/pkgconfig:$(brew --prefix libedit)/lib/pkgconfig:$(brew --prefix libxml2)/lib/pkgconfig:$(brew --prefix openssl)/lib/pkgconfig"

export PATH="$(brew --prefix bison)/bin:$PATH"
