local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities

vim.lsp.config("nil_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    nix = {
      flake = {
        autoArchive = true, -- true, false, or null
      },
    },
  },
})

vim.lsp.enable("nil_ls")
