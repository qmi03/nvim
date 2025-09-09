return {
  "goolord/alpha-nvim",
  lazy = true,
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/oil.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
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
      dashboard.button("f", "󰱼  > Find file", ":Telescope find_files<CR>"),
      dashboard.button("g", "󰱼  > Find grep", ":Telescope live_grep<CR>"),
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
    local function get_nvim_version()
      local version = vim.version()
      return string.format(
        "Neovim v%d.%d.%d",
        version.major,
        version.minor,
        version.patch
      )
    end

    dashboard.section.footer.val = get_nvim_version()
    dashboard.section.footer.opts.hl = "Comment"

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer and add keymaps
    vim.cmd [[
      autocmd FileType alpha setlocal nofoldenable
      autocmd FileType alpha nnoremap <buffer> <cr> <cmd>lua require('alpha.themes.dashboard').buttons.eval()<cr>
      autocmd FileType alpha nnoremap <buffer> q :q<cr>
    ]]
  end,
}
