call plug#begin('~/.vim/plugged')

  Plug 'jeffkreeftmeijer/vim-dim'
  Plug 'dracula/vim'

" nvim 0.5 features
  Plug 'hrsh7th/nvim-compe'
  " dependencies
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  " telescope
  Plug 'nvim-telescope/telescope.nvim'
  " treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  " lsp-config
  Plug 'neovim/nvim-lspconfig'
  " compe
  Plug 'hrsh7th/nvim-compe'

" tests
Plug 'vim-test/vim-test'

" Interacting with tmux
Plug 'benmills/vimux'

" Git
Plug 'tpope/vim-fugitive'

" GitHub
Plug 'pwntester/octo.nvim'

Plug 'ThePrimeagen/vim-be-good'

Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

