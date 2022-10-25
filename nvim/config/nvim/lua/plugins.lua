local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically compile Packer on write
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


-- Plugins
return require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" }

  -- Colorschemes
  use 'p00f/alabaster_dark.nvim'
  use 'jaredgorski/fogbell.vim'
  use 'projekt0n/github-nvim-theme'
  use 'kdheepak/monochrome.nvim'
  use 'navarasu/onedark.nvim'
  use 'owickstrom/vim-colors-paramount'
  use 'rmehri01/onenord.nvim'

  -- Startup screen
  use {
    "goolord/alpha-nvim",
    requires = {
      'sindrets/diffview.nvim',
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  }

  use({
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        render = "minimal"
      })
      vim.notify = notify
    end,
  })


  -- Better icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end
  })

  -- WhichKey
  use {
    "folke/which-key.nvim",
    config = function()
      require("config.whichkey").setup()
    end,
  }


  -- Better Comment
  use {
    "numToStr/Comment.nvim",
    opt = true,
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("Comment").setup {}
    end,
  }

  -- using leap.nvim instead of lightspeed and hop
  -- Easy hopping
  -- use {
  --   "phaazon/hop.nvim",
  --   branch = 'v2',
  --   cmd = { "HopWord", "HopChar1" },
  --   config = function()
  --     require("hop").setup {}
  --   end,
  -- }

  -- use {
  --   "ggandor/lightspeed.nvim",
  --   keys = { "s", "S", "f", "F", "t", "T" },
  --   config = function()
  --     require("lightspeed").setup {}
  --   end,
  -- }

  -- Better motion
  use {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  }

  -- Git
  use {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('config.neogit').setup()
    end,
  }

  -- IndentLine
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup({
        show_first_indent_level = false,
        use_treesiter = true,
        filetype_exclude = { "help", "packer" },
        buftype_exclude = { "terminal", "nofile" },
        show_current_context = true,
        context_char = "|",
      })
    end,
  }

  -- text objects for ruby
  use({
    "nelstrom/vim-textobj-rubyblock",
    requires = "kana/vim-textobj-user",
  })

  -- wisely add "end" on blocks for ruby files
  use "RRethy/nvim-treesitter-endwise"

  -- Auto HTML tag
  use {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup { enable = true }
    end,
  }

  -- better word motion
  use { "chaoren/vim-wordmotion" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0",
    requires = { "RRethy/nvim-treesitter-endwise", "andymass/vim-matchup", "nvim-treesitter/nvim-treesitter-textobjects" },
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_install = false,

        highlight = {
          enable = true,
        },

        matchup = {
          enable = true,
        },

        endwise = {
          enable = true,
        },

        textobjects = {
          select = {
            enable = true,
            keymaps = {
              -- Capture groups described in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aC"] = "@class.outer",
              ["iC"] = "@class.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ae"] = "@block.outer",
              ["ie"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["ad"] = "@comment.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          }
        }
      })
    end,
  }

  -- show current context with treesitter
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { 
      "nvim-lua/popup.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup {}
        end,
      },
    },
    config = function()
      require("config.telescope").setup()
    end,
  })

  -- Status line
  use {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = [[require('config.lualine')]],
    requires = { "nvim-web-devicons" },
  }

  -- A buffer line with tabppage integration
  use {
    "akinsho/bufferline.nvim",
    tag = "v3.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require('config.bufferline')]],
  }


  -- Add/change/delete surrounding delimiter pairs with ease.
  use({
    "kylechui/nvim-surround",
    tag = "*", 
    config = function()
        require("nvim-surround").setup({
        })
    end
  })

  -- nvim-gps to show the current scope
  use {
    "SmiteshP/nvim-gps",
    -- requires = "nvim-treesitter/nvim-treesitter",
    module = "nvim-gps",
    config = function()
      require("nvim-gps").setup()
    end,
  }

  -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    requires = "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  })
  -- Completion plugin for neovim
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "ray-x/cmp-treesitter",
    },
    config = [[require('config.cmp')]],
  })

  -- Auto pairs
  use {
    "windwp/nvim-autopairs",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
       require("nvim-autopairs").setup {
         check_ts = true
       }
    end,
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require("octo").setup()
    end
  }

  -- LSP --working
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use({
    "neovim/nvim-lspconfig",
    config = [[require('config.lsp')]],
    requires = {
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup {}
        end,
      },
    }
  })

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    requires = {
      "Pocco81/dap-buddy.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
      "mfussenegger/nvim-dap-python",
      "suketa/nvim-dap-ruby",
    },
    config = function()
      require("config.dap").setup()
    end,
  }


  if packer_bootstrap then
    print "Restart Neovim required after installation!"
    require("packer").sync()
  end
end)
