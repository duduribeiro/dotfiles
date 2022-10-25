local M = {}

-- Custom actions
local transform_mod = require("telescope.actions.mt").transform_mod
local nvb_actions = transform_mod {
  file_path = function(prompt_bufnr)
    -- Get selected entry and the file full path
    local content = require("telescope.actions.state").get_selected_entry()
    local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

    -- Yank the path to unnamed register
    vim.fn.setreg('"', full_path)

    -- Close the popup
    require("utils").info "File path is yanked "
    require("telescope.actions").close(prompt_bufnr)
  end,
}

function M.setup()
  local actions = require "telescope.actions"
  local telescope = require "telescope"

  telescope.setup {
    defaults = {
      file_ignore_patterns = { "rbi", "node_modules" },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
      },
    },
    pickers = {
      find_files = {
        theme = "ivy",
      },
      git_files = {
        theme = "dropdown",
      },
    },
  }

  telescope.load_extension "fzf"
  telescope.load_extension "project" -- telescope-project.nvim
  telescope.load_extension "file_browser"
  telescope.load_extension "projects" -- project.nvim
end

return M

