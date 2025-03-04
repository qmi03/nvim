return {
  "VonHeikemen/fine-cmdline.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.api.nvim_set_keymap(
      "n",
      ":",
      "<cmd>FineCmdline<CR>",
      { noremap = true }
    )
    require("fine-cmdline").setup {
      cmdline = {
        prompt = ":",
      },
      popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = "60%",
        },
      },
    }
  end,
}
