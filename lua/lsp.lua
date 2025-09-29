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
  "clangd",
  "cmake",

  "denols",
  "dockerls",
  "docker_compose_language_service",

  "emmet_language_server",

  "gleam",
  "gopls",

  "jdtls",

  "lemminx",
  "lua_ls",

  "marksman",

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
