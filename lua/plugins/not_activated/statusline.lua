return {
  {
    'feline-nvim/feline.nvim',
    dependencies = { "catppuccin/nvim" },
    config = function()
      local ok, ctp_feline = pcall(require, 'catppuccin.groups.integrations.feline')
      if ok then
        ctp_feline.setup()
        local components = ctp_feline.get_statusline()
        local navic = require("nvim-navic")

        table.insert(components.active[1], {
          provider = function()
            return navic.get_location()
          end,
          enabled = function()
            return navic.is_available()
          end
        })
        require("feline").setup({
          components = components,
        })
      else
        require("feline").setup()
      end
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },  -- optional, for icons
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              -- fmt = function(str)
              --   -- Add recording indicator to the mode section
              --   return str
              --       .. (
              --         vim.fn.reg_recording() ~= ""
              --         and " recording @" .. vim.fn.reg_recording()
              --         or ""
              --       )
              -- end,
              require("recorder").recordingStatus
            },
          },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}
