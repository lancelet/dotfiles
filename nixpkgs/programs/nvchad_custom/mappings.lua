local M = {}

M.nvterm = {
  plugin = true,
  n = {
    ["<C-/>"] = {
      function()
        require("nvterm.terminal").toggle("float")
      end,
      "Toggle floating term"
    }
  },
  t = {
    ["<C-/>"] = {
      function()
        require("nvterm.terminal").toggle("float")
      end,
      "Toggle floating term"
    }
  }
}

return M
