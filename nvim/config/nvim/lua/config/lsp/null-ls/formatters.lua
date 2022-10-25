local M = {}

local nls_utils = require "config.lsp.null-ls.utils"
local nls_sources = require "null-ls.sources"

local method = require("null-ls").methods.FORMATTING

M.autoformat = true

function M.list_registered(filetype)
  local registered_providers = nls_utils.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

function M.list_supported(filetype)
  local supported_formatters = nls_sources.get_supported(filetype, "formatting")
  table.sort(supported_formatters)
  return supported_formatters
end

return M
