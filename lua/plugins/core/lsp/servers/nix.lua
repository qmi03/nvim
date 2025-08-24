local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig = require "lspconfig"

lspconfig.nil_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    nix = {
      flake = {
        autoArchive = true,   -- Set to true, false, or null based on your preference
      },
    },
  },
}
