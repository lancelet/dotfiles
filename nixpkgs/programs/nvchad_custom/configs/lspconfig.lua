local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

-- This is the LSP config plugin.
-- Unknown why there's an error saying it is imported under
-- a different name.
local lspconfig = require("lspconfig")

-- Basic servers
local servers = {
  "cssls",
  "html"
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

-- Additional servers

-- Rust LSP
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  diagonstics = {
    enable = false
  }
})

-- Python LSP
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"}
})
