return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require "plugins.core.lsp.configs.format"
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
}
