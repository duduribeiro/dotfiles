 " Set , as leader key
let mapleader = ","

set number             " shows the line number
set textwidth=120      " limit line to 120 chars
set clipboard^=unnamed " Use system's clipboard in the system register
set ignorecase
set smartcase
set splitright
nnoremap <CR> :noh<CR>

" Indenting rules
set expandtab        " Use spaces instead of tabs
set tabstop=2        " number of spaces to replace tab with
set softtabstop=2
set shiftwidth=2     " the number of spaces to be used when using shifting `>` `<`
set textwidth=120    " Vim will auto-break long lines if it's more than 80 chars
set autoindent       " copy the indent from the previous line when pressing Enter

set termguicolors
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace


syntax on
filetype on
filetype plugin on
filetype plugin indent on

set foldenable
set foldmethod=indent "folding by indent
set foldlevel=99

" Give more space for displaying messages.
set cmdheight=2

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

au FileType gitcommit setlocal tw=72 " automatically wrap on 72 col for git commit message
