-- add completions capabilities to lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- add navic to lsp
local on_attach = function(client, bufnr)
  if not client then
    return
  end
  client.server_capabilities.document_formatting = true
  local navic = require "nvim-navic"
  if
      client.server_capabilities.documentSymbolProvider
      and client.name ~= "null-ls"
  then
    navic.attach(client, bufnr)
  end
end

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

local servers = {
  "astro",

  "clangd",
  "cmake",

  "dockerls",
  "docker_compose_language_service",

  "gleam",
  "gopls",

  "jdtls",

  "lemminx",
  "lua_ls",

  "marksman",
  "mdx",

  "nil_ls",

  "phpactor",
  "pylsp",

  "rust_analyzer",
  "ruff",

  "sourcekit",
  "svelte",

  "taplo",
  "texlab",
  "tinymist",
  "ts_ls",

  "unison",

  "zls",
}

vim.lsp.enable(servers)

-- Configure syntax highlighting for fenced code blocks in Markdown files
-- This tells Vim/Neovim how to highlight code inside markdown code fences
-- Format: "shorthand=actual_language"
-- Example: using ```ts in markdown will apply TypeScript syntax highlighting
vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "js=javascript",
  "py=python",
  "sh=bash",
}

local null_ls = require "null-ls"
null_ls.setup {
  sources = {
    -- js
    -- require("none-ls.diagnostics.eslint_d"),
    null_ls.builtins.formatting.prettierd,

    -- ruby
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.diagnostics.rubocop,

    -- nix format
    null_ls.builtins.formatting.nixpkgs_fmt,

    -- swift and c
    -- null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.swiftformat,
    -- null_ls.builtins.diagnostics.swiftlint,
    -- null_ls.builtins.diagnostics.checkmake,

    -- markdown
    null_ls.builtins.formatting.markdownlint,

    -- python
    null_ls.builtins.formatting.isort,

    -- yaml
    null_ls.builtins.formatting.yamlfmt,
  },
}
