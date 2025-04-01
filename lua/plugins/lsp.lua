return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "plugins.configs.lsp"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require "plugins.configs.format"
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rust_autosave = 1
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },
}
