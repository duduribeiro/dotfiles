let s:config_path = $HOME.'/.config/nvim/'
let s:config_files = [
      \'commons.vim',
      \'functions.vim',
      \'plugins.vim',
      \'mappings.vim',
      \'plugins-configs.vim',
      \]

for file in s:config_files
  if filereadable(s:config_path.file)
    exec "so ".s:config_path.file
  endif
endfor

let g:doom_one_terminal_colors = v:true
