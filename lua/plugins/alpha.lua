return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/oil.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"

    -- Set header

    local logo_data = require "plugins.configs.alpha_img"
    local logos = {
      logo_data.qmi_deptrai,

      logo_data.luffy_nika,
      logo_data.luffy_small,
      logo_data.one_piece_1,
      logo_data.one_piece_2,
    }

    math.randomseed(os.time())
    local logo = logos[math.random(#logos)]

    local function pick_color()
      local colors = { "String", "Identifier", "Keyword", "Number" }
      return colors[math.random(#colors)]
    end

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.header.opts.hl = pick_color()

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰱼  > Find file", ":Telescope find_files<CR>"),
      dashboard.button(
        "r",
        "  > Recent",
        ":lua require('telescope.builtin').oldfiles({only_cwd = true})<CR>"
      ),
      dashboard.button(
        "s",
        "  > Settings",
        ":e $MYVIMRC | :cd %:p:h | Oil<CR>"
      ),
      dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
    }

    -- Set footer
    --   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
    --   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
    --   ```init.lua
    --   return require('packer').startup(function()
    --       use 'wbthomason/packer.nvim'
    --       use {
    --           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
    --           requires = {'BlakeJC94/alpha-nvim-fortune'},
    --           config = function() require("config.alpha") end
    --       }
    --   end)
    --   ```
    -- local fortune = require("alpha.fortune")
    -- dashboard.section.footer.val = fortune()

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[
    autocmd FileType alpha setlocal nofoldenable
]]
  end,
}
