if status is-interactive
    # Commands to run in interactive sessions can go here
end

source /usr/local/opt/asdf/libexec/asdf.fish

# aliases
if test -e ~/.aliases
  source ~/.aliases
end
