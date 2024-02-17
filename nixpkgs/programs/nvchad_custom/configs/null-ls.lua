-- Auto-save. Disabled for now.
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require('null-ls')

local opts = {
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = {"--ignore-missing-imports"}
    }),
    null_ls.builtins.diagnostics.ruff
  },
  -- The block below handles auto-save. Disabled for now.
  --
  -- on_attach = function(client, buffer_number)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({
  --       group = augroup,
  --       buffer = buffer_number
  --     })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = buffer_number,
  --       callback = function ()
  --         vim.lsp.buf.format({ bufnr = buffer_number })
  --       end
  --     })
  --   end
  -- end,
}

return opts
