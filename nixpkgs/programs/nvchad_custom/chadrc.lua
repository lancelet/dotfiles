---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'doomchad',
  statusline = {
    theme = "default",
    separator_style = "default"
  },
  hl_override = {
    Comment = {
      fg = "teal"
    }
  }
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
