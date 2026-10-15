return {
  "0x00-ketsu/autosave.nvim",
  -- lazy-loading on events
  event = { "InsertLeave", "TextChanged" },
  config = function()
    require("autosave").setup {
      enable = false,
      prompt = {
        enable = true,
        style = "stdout",
        message = function()
          return "Autosave: saved at " .. vim.fn.strftime "%H:%M:%S"
        end,
      },
      events = { "InsertLeave", "TextChanged" },
      conditions = {
        exists = true,
        modifiable = true,
        filetype_is_not = {
          "harpoon",
          "oil",
          "alpha",
          "NvimTree",
          "neo-tree",
          "toggleterm",
          "TelescopePrompt",
        },
      },
      write_all_buffers = false,
      debounce_delay = 135,
    }
    vim.keymap.set(
      "n",
      "<leader>as",
      require("autosave.action").toggle,
      { desc = "Toggle auto save" }
    )
  end,
}
