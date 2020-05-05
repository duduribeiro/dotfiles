" ==========
" Plugins
" ==========
call plug#begin('~/.vim/plugged')

" Collection of color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'arcticicestudio/nord-vim'

" Provide additional text objects
Plug 'wellle/targets.vim'

" Extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers
Plug 'junegunn/vim-peekaboo'

" Automatic resizing of Vim windows
Plug 'roman/golden-ratio'

" Tree navigation
Plug 'scrooloose/nerdtree'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Handle Ctags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Modern matchit replacement
Plug 'andymass/vim-matchup'

" Auto close brackets, parens, quotes
Plug 'jiangmiao/auto-pairs'

" Auto close blocks
Plug 'tpope/vim-endwise'

" Always highlight html tags
Plug 'Valloric/MatchTagAlways'

" Comment Stuffs
Plug 'tpope/vim-commentary'

" Surround stuffs
Plug 'machakann/vim-sandwich'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Search and replace through the whole project
Plug 'brooth/far.vim'

" Remove trailing whitespaces
Plug 'axelf4/vim-strip-trailing-whitespace'

" Linting
Plug 'w0rp/ale'

" IntelliSense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

" Test Runner
Plug 'janko/vim-test'

" Interacting with tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Languages
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

call plug#end()

" ==========
" End Plugins
" ==========

syntax on
filetype plugin indent on

let mapleader = " " " Set space as leader key
let g:loaded_matchit = 1 " Disable matchit in order to use vim-matchup

let g:python_host_prog = '/usr/bin/python' " Set python binary location
let g:python3_host_prog = '/usr/bin/python3' " Set python binary location

if exists('$TMUX')
  " Colors in tmux
  let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme nord " Set colorscheme
set t_Co=256
set termguicolors
set background=dark

" Prevent a user from using arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set number             " shows the line number
set textwidth=120      " limit line to 120 chars
set clipboard^=unnamed " Use system's clipboard in the system register 
set ignorecase
set smartcase
nnoremap <CR> :noh<CR>

" Indenting rules
set expandtab        " Use spaces instead of tabs
set tabstop=2        " number of spaces to replace tab with
set softtabstop=2
set shiftwidth=2     " the number of spaces to be used when using shifting `>` `<`
set textwidth=120    " Vim will auto-break long lines if it's more than 80 chars
set autoindent       " copy the indent from the previous line when pressing Enter

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quicker window movement
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" ==========
" NERDTree
" ==========
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close Vim if NERDTree is the only window open

" ==========
" FZF.vim
" ==========

nnoremap <Leader><Leader> :Files<cr>
nnoremap <Leader>b :Buffers<cr>

" let g:fzf_action = {
"        \ 'enter': 'split',
"        \ 'ctrl-t': 'tab split',
"        \ 'ctrl-v': 'vsplit' }

" Press <LEADER> + f on a word to search for it
nnoremap <Leader>f :Ag <C-R><C-W><cr>
vnoremap <Leader>f y:Ag <C-R>"<cr>

" Pressing Ctrl+f and type the search pattern
nnoremap <C-F> :Ag<Space>”

" ==========
" Ale
" ==========
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
nnoremap <leader>d :ALEDetail<cr>
let g:ale_disable_lsp = 1

" =========
" Coc
" =========

" ==========
" vim-fugitive
" ==========
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>


" ==========
" vim-test
" ==========
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vimux" " use vimux as strategy to send test to tmux

" ==========
" vim-gutentags
" ==========
let g:gutentags_project_root = ['.git', '.svn', '.root', '.hg', '.project']
" let g:gutentags_ctags_tagfile = '.tags'
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--c++-kinds=+px', '--c-kinds=+px']
" let g:gutentags_trace = 1
