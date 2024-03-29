return {
  "tpope/vim-projectionist", -- Project configuration

  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        keymaps = {
          ["<leader>e"] = "actions.close",
        },
      })
    end,
  },

  -- "github/copilot.vim",
  --
  -- symbols outline navigation
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("aerial").setup({})
    end,
  },

  -- execute tests directly on vim (vimux is used as strategy to run on a tmux pane
  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    config = function()
      vim.cmd("let test#strategy = 'vimux'")
    end,
  },

  -- Collection of various small independent plugins/modules
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      require("mini.indentscope").setup({
        symbol = "│",
        draw = {
          delay = 1,
        },
      })

      require("mini.bufremove").setup({
        keys = {
          {
            "<leader>bd",
            function()
              local bd = require("mini.bufremove").delete
              if vim.bo.modified then
                local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
                if choice == 1 then -- Yes
                  vim.cmd.write()
                  bd(0)
                elseif choice == 2 then -- No
                  bd(0, true)
                end
              else
                bd(0)
              end
            end,
            desc = "Delete Buffer",
          },
          {
            "<leader>bD",
            function()
              require("mini.bufremove").delete(0, true)
            end,
            desc = "Delete Buffer (Force)",
          },
        },
      })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      require("mini.statusline").setup()
      MiniStatusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  "christoomey/vim-tmux-navigator", -- the plugin will allow you to navigate seamlessly between vim and tmux splits using a consistent set of hotkeys
  --
  -- Search and replace util
  --
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
