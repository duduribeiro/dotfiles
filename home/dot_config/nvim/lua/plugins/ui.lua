return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
            },
          },
        },
        winbar = {
          lualine_c = {
            {
              "navic",
              color_correction = nil,
              navic_opts = nil,
            },
          },
        },
        options = {
          section_separators = "",
          component_separators = "",
          theme = "auto",
          -- ... the rest of your lualine config
        },
      })
    end,
  },

  -- removing buffer line temporarily to see if I can live without it and rely only on Telescope buffer search
  -- buffer line
  -- {
  --   "akinsho/bufferline.nvim",
  --   event = "VeryLazy",
  --   keys = {
  --     { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
  --     { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  --     { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
  --     { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
  --     { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
  --     { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
  --     { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  --     { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
  --     { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  --   },

  --   config = function()

  --     local opts = {
  --       options = {
  --         -- stylua: ignore
  --         close_command = function(n) require("mini.bufremove").delete(n, false) end,
  --         -- stylua: ignore
  --         right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
  --         diagnostics = "nvim_lsp",
  --         always_show_bufferline = false,
  --         offsets = {
  --           {
  --             filetype = "neo-tree",
  --             text = "Neo-tree",
  --             highlight = "Directory",
  --             text_align = "left",
  --           },
  --         },
  --       },
  --     }
  --     local nvim_bufferline = require("bufferline").setup(opts)
  --     -- Fix bufferline when restoring a session
  --     vim.api.nvim_create_autocmd("BufAdd", {
  --       callback = function()
  --         vim.schedule(function()
  --           pcall(nvim_bufferline)
  --         end)
  --       end,
  --     })
  --   end,
  -- },
}
