vim.keymap.set({ "n", "v" }, "q", function()
  vim.api.nvim_win_close(0, true)
end, { buffer = 0 })
