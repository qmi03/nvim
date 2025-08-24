local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig = require "lspconfig"

-- To appropriately highlight codefences returned from denols,
-- you will need to augment vim.g.markdown_fenced languages
vim.g.markdown_fenced_languages = { "ts=typescript" }

lspconfig.denols.setup {
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
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

local vue_language_server_path =
  "/etc/profiles/per-user/qmi/bin/vue-language-server"
lspconfig.ts_ls.setup {
  init_options = {
    {
      plugins = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
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
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
}
lspconfig.svelte.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
