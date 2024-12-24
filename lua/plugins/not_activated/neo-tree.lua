return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup {
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          }
        end,
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define(
        "DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" }
      )
      vim.fn.sign_define(
        "DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" }
      )
      vim.fn.sign_define(
        "DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" }
      )
      vim.fn.sign_define(
        "DiagnosticSignHint",
        { text = "󰌵", texthl = "DiagnosticSignHint" }
      )
      vim.keymap.set("n", "<C-n>", ":Neotree toggle right<CR>", {})

      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
      vim.api.nvim_set_hl(
        0,
        "NeoTreeNormalNC",
        { bg = "NONE", ctermbg = "NONE" }
      )
    end,
  },
}
