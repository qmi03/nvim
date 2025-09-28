return {
  -- we use cmp plugin only when in insert mode
  -- so lets lazyload it at InsertEnter event, to know all the events check h-events
  -- completion , now all of these plugins are dependent on cmp, we load them after cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "petertriho/cmp-git",

      --list of default snippets
      "rafamadriz/friendly-snippets",

      -- snippets engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          local ls = require("luasnip")
          vim.keymap.set({ "i", "s" }, "<M-p>", function()
              if ls.expand_or_jumpable() then
                ls.expand_or_jump()
              end
            end,
            {
              silent = true,
              desc = "Jump snippet forward"
            }
          )
          vim.keymap.set({ "i", "s" }, "<M-n>", function()
              if ls.expand_or_jumpable(-1) then
                ls.expand_or_jump(-1)
              end
            end,
            {
              silent = true,
              desc = "Jump snippet backwards",
            }
          )
        end,
      },

      -- autopairs , autocompletes ()[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()

          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          local cmp = require "cmp"
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
    },
    -- made opts a function cuz cmp config calls cmp module
    -- and we lazyloaded cmp so we dont want that file to be read on startup!
    opts = function()
      return require "plugins.core.lsp.configs.cmp"
    end,
  },
}
