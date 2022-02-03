begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
end

Pry.config.pager = false if ENV['VIM'] || ENV["INSIDE_EMACS"]
Pry.config.correct_indent = false if ENV["INSIDE_EMACS"]

require_relative '.console_functions'
