return {
  -- colorschemes
  { "NLKNguyen/papercolor-theme", lazy = false, priority = 1000 },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        custom_highlights = function(c)
          -- local u = require("catppuccin.utils.colors")
          return {
            -- change here if need to override colors
            -- ["@module"] = { fg = c.yellow },
            -- ["@string.special.symbol.ruby"] = { fg = c.red },
          }
        end,
      })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      local groups = {
        github_light = {
          -- As with specs and palettes, a specific style's value will be used over the `all`'s value.
          Delimiter = { link = "Comment" },
        },
      }
      require("github-theme").setup({ groups = groups })
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark")
    end,
  },
}
