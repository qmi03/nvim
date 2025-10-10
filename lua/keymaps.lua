vim.api.nvim_create_user_command(
  "W",
  "write",
  { desc = "Fix vim write command to use when accidentally use capital w" }
)

-- check lua/plugins/noice.lua config
-- vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- greatest keymap ever
vim.keymap.set("x", "<leader>p", '"_dP')

-- copy file path to clipboard
vim.api.nvim_create_user_command("CopyFilePath", "let @+ = expand('%:p')", {
  desc = "Copy file path to clipboard",
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.keymap.set(
  "n",
  "gf",
  vim.lsp.buf.format,
  { desc = "Format current buffer" }
)

vim.keymap.set("n", "J", function()
  vim.diagnostic.open_float()
end, { desc = "Expand an Error into a float" })
-- Diagnostic keymaps
vim.keymap.set(
  "n",
  "<leader>qf",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- Move lines up/down with Alt+j/k
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("i", "<C-f>", "<Right>", { desc = "Move Right in insert mode" })
vim.keymap.set("i", "<C-b>", "<Left>", { desc = "Move Left in insert mode" })
