if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Load asdf. for mac it is the first option and the second for codespaces
if test -e /usr/local/opt/asdf/libexec/asdf.fish
  source /usr/local/opt/asdf/libexec/asdf.fish
end

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

# aliases
if test -e ~/.aliases
  source ~/.aliases
end

