vim.cmd([[
function! RailsVersion()
  if filereadable('Gemfile.lock')
    for line in readfile('Gemfile.lock')
      let version_string = matchstr(line, '\v^ *railties \(\zs\d+\.\d+\..+\ze\)')
      if version_string
        break
      endif
    endfor

    if version_string
      let rails_version = matchlist(version_string, '\v(\d+)\.(\d+)\.(\d+)%(\.(\d+))?')[1:-1]
      call filter(rails_version, '!empty(v:val)')
      call map(rails_version, 'str2nr(v:val)')

      return rails_version
    end
  endif
endfunction
]])

function toggleColorscheme()
  if vim.g.colors_name == "github_light" then
    vim.cmd([[set background=dark]])
    vim.cmd([[colorscheme catppuccin]])
  else
    vim.cmd([[set background=light]])
    vim.cmd([[colorscheme github_light]])
  end
end
