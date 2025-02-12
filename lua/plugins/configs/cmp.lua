local cmp = require "cmp"
local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<C-H>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
  ls.jump(-1)
end, { silent = true })

return {
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-Space>"] = cmp.mapping.complete(), -- to trigger auto completion manually
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-j>"] = cmp.mapping.confirm { select = true },
    ["<CR>"] = cmp.mapping.confirm { select = false },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
}
