local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities

-- Highlight code fences from denols in markdown
vim.g.markdown_fenced_languages = { "ts=typescript" }

-- denols
vim.lsp.config("denols", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "json",
    "jsonc",
    "markdown",
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "jsx",
    "typescript",
    "typescriptreact",
    "tsx",
  },
  root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
})
vim.lsp.enable("denols")

-- tsserver with Vue plugin
local vue_language_server_path =
"/etc/profiles/per-user/qmi/bin/vue-language-server"

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      name = "@vue/typescript-plugin",
      location = vue_language_server_path,
      languages = { "vue" },
    },
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = require("lspconfig.util").root_pattern("package.json"),
  single_file_support = false,
})
vim.lsp.enable("ts_ls")

-- svelte
vim.lsp.config("svelte", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable("svelte")
