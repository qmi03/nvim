return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    dependencies = { 'feline-nvim/feline.nvim' },
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {     -- :h background
          light = "latte",
          dark = "mocha",
        },
        dim_inactive = {
          enabled = true,          -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,       -- percentage of the shade to apply to the inactive window
        },
        styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
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
            enabled = false,
            custom_bg = "NONE", -- "lualine" will set background to mantle
          },
        },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "EdenEast/nightfox.nvim",
  },
}
