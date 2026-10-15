local cmp = require "cmp"
local extra_mappings = {
  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),

  ["<C-n>"] = cmp.mapping.select_next_item {
    behavior = cmp.SelectBehavior.Insert,
  },
  ["<C-p>"] = cmp.mapping.select_prev_item {
    behavior = cmp.SelectBehavior.Insert,
  },
  -- ["<C-Space>"] = cmp.mapping.complete(), -- to trigger auto completion manually
  ["<C-e>"] = cmp.mapping.abort(),
  ["<C-y>"] = cmp.mapping(
    cmp.mapping.confirm {
      select = true,
      behavior = cmp.SelectBehavior.Insert,
    },
    { "i", "c" }
  ),
  ["<CR>"] = cmp.mapping.confirm { select = false },
}

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})
require("cmp_git").setup()

-- `/` cmdline setup.
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.insert(extra_mappings),
  sources = {
    { name = "buffer" },
  },
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.insert(extra_mappings),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

local lspkind = require "lspkind"
local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable(-1) then
    ls.expand_or_jump(-1)
  end
end, { silent = true })
ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}
for _, ft_path in
  ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true))
do
  loadfile(ft_path)()
end
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
  view = {
    entries = { name = "custom", selection_order = "near_cursor" },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text", -- show only symbol annotations
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      },
    },
  },
  mapping = cmp.mapping.preset.insert(extra_mappings),
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
}
