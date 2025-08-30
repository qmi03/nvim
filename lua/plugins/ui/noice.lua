return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    vim.opt.lazyredraw = false
    require("noice").setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              -- Also filter deprecation from msg_show events
              { find = "vim.deprecated" },
            },
          },
          view = "mini",
        },
      },
    }

    local notify_hl = vim.api.nvim_create_augroup("NotifyHighlights", {})
    vim.api.nvim_clear_autocmds { group = notify_hl }
    vim.api.nvim_create_autocmd("BufEnter", {
      group = notify_hl,
      desc = "redefinition of notify icon colours",
      callback = function()
        vim.api.nvim_set_hl(0, "NotifyINFOIcon", {})
        vim.api.nvim_set_hl(0, "NotifyINFOIcon", { link = "Character" })
      end,
    })
    require("notify").setup {
      background_colour = "#000000",
      timeout = 1000,
      render = "minimal",
      stages = "fade",
      top_down = false,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    }
    vim.keymap.set("n", "<Esc>", function()
      require("notify").dismiss()
      vim.cmd "nohlsearch"
    end, { desc = "dismiss notify popup and clear hlsearch" })
  end,
}
