return {
  "goolord/alpha-nvim",
  lazy = true,
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/oil.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { { "nvim-lua/plenary.nvim" } },
    },
  },
  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"

    -- Set header
    local logo_data = require "plugins.ui.startup.pixel_art"
    local logos = {
      -- logo_data.qmi_deptrai,
      logo_data.luffy_nika,
      logo_data.luffy_small,
      logo_data.one_piece_1,
      logo_data.one_piece_2,
    }

    math.randomseed(vim.loop.hrtime())
    local logo = logos[math.random(#logos)]

    local function pick_color()
      local colors = { "String", "Identifier", "Keyword", "Number" }
      return colors[math.random(#colors)]
    end

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.header.opts.hl = pick_color()
    dashboard.section.header.opts.position = "center"

    -- Dynamic header padding
    local height = vim.o.lines - vim.o.cmdheight
    local header_padding =
        math.floor((height - #dashboard.section.header.val) / 4)
    dashboard.section.header.opts.margin = header_padding

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("r", "⏳ > Recent", function()
        require("telescope.builtin").oldfiles { only_cwd = true }
      end),
      dashboard.button("e", "📄 > Empty buffer", function()
        vim.cmd("enew")
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "hide"
        vim.bo.swapfile = false
      end),
      dashboard.button("f", "📄 > Find files", function()
        require("telescope.builtin").find_files { only_cwd = true }
      end),
      dashboard.button("/", "🔍 > Find grep", require("telescope.builtin").live_grep),
      dashboard.button("t", "🔭 > Telescope", require("telescope.builtin").builtin),
      dashboard.button("g", "  > Git", function()
        vim.cmd "Neogit"
      end),
      dashboard.button("h", "🔱 > Harpoon", function()
        local harpoon = require "harpoon"
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end),
    }

    -- Set footer
    local function setup_footer()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local lazy = require("lazy").stats()
          dashboard.section.footer.val = string.format(
            "⚡ Loaded %d/%d plugins in %.2fms",
            lazy.loaded,
            lazy.count,
            lazy.startuptime
          )
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end

    setup_footer()
    dashboard.section.footer.opts.hl = "Comment"

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer and add keymaps
    vim.cmd [[
      autocmd FileType alpha setlocal nofoldenable
      autocmd FileType alpha nnoremap <buffer> <cr> <cmd>lua require('alpha.themes.dashboard').buttons.eval()<cr>
      autocmd FileType alpha nnoremap <buffer> q :qa<cr>
    ]]
  end,
}
