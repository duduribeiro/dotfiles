return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "zidhuss/neotest-minitest",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-minitest"),
        },
      })
    end,
  },
}
