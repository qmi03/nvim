return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "plugins.core.lsp.servers.init"
    end,
  },
  {
    "nvim-lua/lsp-status.nvim",
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  require "plugins.core.lsp.formatting",
}
