return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("lazydocker").setup {
      popup_window = {
        enter = true,
        focusable = true,
        zindex = 40,
        position = "50%",
        relative = "win",
        size = {
          width = "90%",
          height = "90%",
        },
        buf_options = {
          modifiable = true,
          readonly = false,
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          winblend = 0,
        },
        border = {
          highlight = "FloatBorder",
          style = "rounded",
          text = {
            top = " Lazydocker ",
          },
        },
      },
    }
    vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>LazyDocker<CR>", {})
  end,
}
