return {
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.cmd("set background=dark")
        vim.cmd("colorscheme github_dark")
      end,
      set_light_mode = function()
        vim.cmd("set background=light")
        vim.cmd("colorscheme github_light")
      end,
    },
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "olimorris/onedarkpro.nvim", priority = 1000 },
  { "sainnhe/edge", priority = 1000 },
  { "projekt0n/github-nvim-theme", priority = 1000 },
}
