local overrides = require "custom.configs.overrides"

local plugins = {
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- This first require is for the default NvChad config
      require "plugins.configs.lspconfig"
      -- The second require is for custom config
      require "custom.configs.lspconfig"
    end
  },
  -- This is here to override the nvterm size.
  {
    "NvChad/nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function()
      require "base46.term"
      require("nvterm").setup(overrides.nvterm)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "rust"
      }
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      M = require "plugins.configs.nvimtree"
      M.view.adaptive_size = false
      M.view.width = 60
      require("nvim-tree").setup(M)
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",           -- Python code formatter
        "html-lsp",        -- HTML LSP plugin
        -- "mypy",            -- mypy type checker (install in env instead)
        "pyright",         -- Python LSP plugin
        "ruff",            -- Python linter and code formatter
        "rust-analyzer",   -- Rust LSP plugin
      }
    }
  }
}

return plugins
