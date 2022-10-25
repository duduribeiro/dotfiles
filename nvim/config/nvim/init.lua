require("plugins")

local api = vim.api
local g   = vim.g
local opt = vim.opt

-- Basic settings
vim.g.mapleader = " " -- Set leader key to space

opt.number = true -- Show line numbers
opt.expandtab = true -- Use spaces instead of tabs
opt.relativenumber = true -- Show relative line numbers

-- vim.cmd 'colorscheme github_dark' -- colorscheme
require('onedark').load()

-- github-theme is not working with most recent treesitter yet
-- require('github-theme').setup({
--   theme_style = "dark",
-- })

-- syntax highlighting
opt.termguicolors = true -- Enable colors in terminal
vim.g.t_Co = 256

opt.hlsearch = true --Set highlight on search
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.updatetime = 250 --Decrease update time
opt.timeoutlen = 300	--	Time in milliseconds to wait for a mapped sequence to complete.

-- remove /usr/include and all subdirectories from current path into the search path
opt.path:remove "/usr/include"
opt.path:append "**"
opt.wildignorecase = true
-- ignore some specific folders from search path
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/tmp/*"
opt.wildignore:append "**/.git/*"
opt.wildignore:append "**/build/*"

 -- Set completeopt to have a better completion experience
opt.completeopt = "menu,menuone,noselect"

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
