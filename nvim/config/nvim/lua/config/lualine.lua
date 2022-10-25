local lualine = require("lualine")
local gps = require("nvim-gps")

local function file_percent()
  local percent = math.floor(100 * vim.fn.line(".") / vim.fn.line("$"))
  return string.format("☰ %s%%%%", percent)
end


-- local function lsp_client()
--   local buf_clients = vim.lsp.buf_get_clients()
--   if next(buf_clients) == nil then
--     return ""
--   end
--   local buf_client_names = {}
--   for _, client in pairs(buf_clients) do
--     if client.name ~= "null-ls" then
--       table.insert(buf_client_names, client.name)
--     end
--   end
--   return "[" .. table.concat(buf_client_names, ", ") .. "]"
-- end

local function lsp_client(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- add formatter
  local formatters = require "config.lsp.null-ls.formatters"
  local supported_formatters = formatters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_formatters)

  -- add linter
  local linters = require "config.lsp.null-ls.linters"
  local supported_linters = linters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_linters)

  -- add hover
  local hovers = require "config.lsp.null-ls.hovers"
  local supported_hovers = hovers.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_hovers)

  return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

local function lsp_progress(_, is_active)
  if not is_active then
    return
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    local title = ""
    if msg.title then
      title = msg.title
    end
    table.insert(status, (msg.percentage or 0) .. "%% " .. title)
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, "  ") .. " " .. spinners[frame + 1]
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "nord",
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_b = {
      { "filename", symbols = { modified = " ", readonly = " " } },
      {
        gps.get_location,
        cond = gps.is_available,
        color = { fg = "#f3ca28" },
      }
    },
    lualine_c = {
      { "branch", separator = "" },
      { "diff", left_padding = 0, symbols = { added = " ", modified = " ", removed = " " } },
    },
    lualine_x = {
      { lsp_client, icon = " ", color = { fg = "#a9a1e1", gui = "bold" } },
      { lsp_progress },
      { "diagnostics", sources = { "nvim_diagnostic" } }
    },
    lualine_y = { "filetype" },
    lualine_z = { "location", file_percent },
  },
  inactive_sections = {
    lualine_b = { { "filename", symbols = { modified = " ", readonly = " " } } },

    lualine_c = { { "diff", symbols = { added = " ", modified = " ", removed = " " } } },
    lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } } },
    lualine_y = { "filetype" },
  },
  -- extensions = { "toggleterm", "fzf", "nvim-tree", "fugitive" },
})

