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
