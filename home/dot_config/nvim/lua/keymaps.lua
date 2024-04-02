-- Oil
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "File navigation [e]xplorer" })

-- vim-test
vim.keymap.set("n", "<Leader>tt", ":TestFile<CR>", { desc = "Run [T]est for [f]ile" })
vim.keymap.set("n", "<Leader>tn", ":TestNearest<CR>")
vim.keymap.set("n", "<Leader>tl", ":TestLast<CR>")
vim.keymap.set("n", "<Leader>ta", ":TestSuite<CR>")
vim.keymap.set("n", "<Leader>tg", ":TestVisit<CR>")

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>m", vim.diagnostic.open_float, { desc = "Show diagnostic Error [m]essages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Toggle colorscheme
vim.keymap.set(
  "n",
  "<leader>ct",
  "<cmd>lua toggleColorscheme()<CR>",
  { desc = "toggle Colorscheme between light/dark" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>", { desc = "Move focus to the left window", silent = true })
vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>", { desc = "Move focus to the right window", silent = true })
vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>", { desc = "Move focus to the lower window", silent = true })
vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>", { desc = "Move focus to the upper window", silent = true })

-- LSP inc rename
vim.keymap.set("n", "<leader>cr", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename" })

-- Document existing key chains
require("which-key").register({
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
  ["[b"] = { "<cmd>bp<CR>", "previous buffer" },
  ["]b"] = { "<cmd>bn<CR>", "next buffer" },
  ["<leader>b"] = {
    name = "Buffers",
    D = {
      function()
        require("mini.bufremove").delete(0, true)
      end,
      "Delete buffer (Force)",
    },
    d = {
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
      "Delete buffer",
    },
  },
})

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
