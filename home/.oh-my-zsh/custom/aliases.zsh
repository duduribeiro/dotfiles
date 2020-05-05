alias vim='nvim'
alias re='git checkout $(git recent | fzf)'
alias cat='bat'
alias ls="exa"
alias find="fd"
alias grmb='git branch --merged | grep -v "\*" | grep -v master | grep -v staging | xargs -n 1 git branch -d'
alias tmux="TERM=xterm-256color tmux -2"
