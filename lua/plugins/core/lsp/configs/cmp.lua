local cmp = require "cmp"
local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<C-H>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
  ls.jump(-1)
end, { silent = true })
local extra_mappings = {
  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  -- ["<C-Space>"] = cmp.mapping.complete(), -- to trigger auto completion manually
  ["<C-e>"] = cmp.mapping.abort(),
  ["<C-j>"] = cmp.mapping.confirm { select = true },
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
cmp.setup.cmdline("/", {
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
  mapping = cmp.mapping.preset.insert(extra_mappings),
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
}
-- call plug#begin(s:plug_dir)
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'hrsh7th/cmp-nvim-lsp'
-- Plug 'hrsh7th/cmp-buffer'
-- Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-cmdline'
-- Plug 'hrsh7th/nvim-cmp'
--
-- " For vsnip users.
-- Plug 'hrsh7th/cmp-vsnip'
-- Plug 'hrsh7th/vim-vsnip'
--
-- " For luasnip users.
-- " Plug 'L3MON4D3/LuaSnip'
-- " Plug 'saadparwaiz1/cmp_luasnip'
--
-- " For mini.snippets users.
-- " Plug 'echasnovski/mini.snippets'
-- " Plug 'abeldekat/cmp-mini-snippets'
--
-- " For ultisnips users.
-- " Plug 'SirVer/ultisnips'
-- " Plug 'quangnguyen30192/cmp-nvim-ultisnips'
--
-- " For snippy users.
-- " Plug 'dcampos/nvim-snippy'
-- " Plug 'dcampos/cmp-snippy'
--
-- call plug#end()
--
--   local cmp = require'cmp'
--
--   cmp.setup({
--     snippet = {
--       -- REQUIRED - you must specify a snippet engine
--       expand = function(args)
--         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--         -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--
--         -- For `mini.snippets` users:
--         -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
--         -- insert({ body = args.body }) -- Insert at cursor
--         -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
--         -- require("cmp.config").set_onetime({ sources = {} })
--       end,
--     },
--     window = {
--       -- completion = cmp.config.window.bordered(),
--       -- documentation = cmp.config.window.bordered(),
--     },
--     mapping = cmp.mapping.preset.insert({
--       ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--       ['<C-f>'] = cmp.mapping.scroll_docs(4),
--       ['<C-Space>'] = cmp.mapping.complete(),
--       ['<C-e>'] = cmp.mapping.abort(),
--       ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--     sources = cmp.config.sources({
--       { name = 'nvim_lsp' },
--       { name = 'vsnip' }, -- For vsnip users.
--       -- { name = 'luasnip' }, -- For luasnip users.
--       -- { name = 'ultisnips' }, -- For ultisnips users.
--       -- { name = 'snippy' }, -- For snippy users.
--     }, {
--       { name = 'buffer' },
--     })
--   })
--
--   -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
--   -- Set configuration for specific filetype.
--   --[[ cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--       { name = 'git' },
--     }, {
--       { name = 'buffer' },
--     })
--  })
--  require("cmp_git").setup() ]]--
--
--   -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--   cmp.setup.cmdline({ '/', '?' }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--       { name = 'buffer' }
--     }
--   })
--
--   -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--   cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--       { name = 'path' }
--     }, {
--       { name = 'cmdline' }
--     }),
--     matching = { disallow_symbol_nonprefix_matching = false }
--   })
--
--   -- Set up lspconfig.
--   local capabilities = require('cmp_nvim_lsp').default_capabilities()
--   -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--   require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--     capabilities = capabilities
--   }
-- EOF
