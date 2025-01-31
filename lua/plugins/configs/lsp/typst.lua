local my_utils = require "plugins.configs.lsp.utils"
local old_on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local on_attach = function(client, bufnr)
  old_on_attach(client, bufnr)
  vim.lsp.buf.execute_command {
    command = "tinymist.pinMain",
    -- arguments = { vim.fs.joinpath(vim.fs.root(0,{"main.typ"}), "main.typ") },
    arguments = { vim.fs.joinpath(vim.fn.getcwd(), "main.typ") },
  }
end
local lspconfig = require "lspconfig"

lspconfig.tinymist.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  offset_encoding = "utf-8",
  settings = {
    exportPdf = "onType",
    outputPath = "$root/target/$dir/$name",

    formatterMode = "typstyle",
    formatterPrintWidth = 80,
  },
}
-- pin the main file
vim.api.nvim_create_user_command("TypUnpin", function()
  vim.lsp.buf.execute_command {
    command = "tinymist.pinMain",
    arguments = { nil },
  }
end, {})
