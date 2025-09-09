return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    dependencies = { "feline-nvim/feline.nvim", "SmiteshP/nvim-navic" },
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = { "italic" },
          keywords = { "bold" },
          strings = { "italic" },
          variables = {},
          numbers = { "italic" },
          booleans = { "italic" },
          properties = {},
          types = {},
          operators = { "bold" },
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        integrations = {
          cmp = true,
          mason = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          colorful_winsep = {
            enabled = false,
          },
          fidget = true,
          fzf = true,
          harpoon = true,
          navic = {
            enabled = true,
          },
        },
      }
      local ctp_feline = require "catppuccin.groups.integrations.feline"
      ctp_feline.setup()
      local components = ctp_feline.get_statusline()

      local navic = require "nvim-navic"
      table.insert(components.active[1], {
        provider = function()
          return navic.get_location()
        end,
        enabled = function()
          return navic.is_available()
        end,
      })

      navic.setup {
        highlight = true,
      }
      require("feline").setup {
        components = components,
      }
    end,
  },
}
