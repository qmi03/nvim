local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities

vim.lsp.config("emmet_language_server", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
    "php",
  },
  init_options = {
    includeLanguages = {},
    excludeLanguages = {},
    extensionsPath = {},
    preferences = {},
    showAbbreviationSuggestions = true,
    showExpandedAbbreviation = "always",
    showSuggestionsAsSnippets = false,
    syntaxProfiles = {},
    variables = {},
  },
})

-- enable lazily when opening supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
    "php",
  },
  callback = function()
    vim.lsp.enable("emmet_language_server")
  end,
})
