local my_utils = require "plugins.configs.lsp.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig = require "lspconfig"
lspconfig.phpactor.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
  },
}
