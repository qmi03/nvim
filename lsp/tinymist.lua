local on_attach = function(client, bufnr)
  if not client then
    return
  end
  client.server_capabilities.document_formatting = true
  local navic = require "nvim-navic"
  if client.server_capabilities.documentSymbolProvider and client.name ~= "null-ls" then
    navic.attach(client, bufnr)
  end

  vim.keymap.set("n", "<leader>tp", function()
    client:exec_cmd({
      title = "pin",
      command = "tinymist.pinMain",
      arguments = { vim.api.nvim_buf_get_name(0) },
    }, { bufnr = bufnr })
  end, { desc = "[T]inymist [P]in", noremap = true })

  vim.keymap.set("n", "<leader>tu", function()
    client:exec_cmd({
      title = "unpin",
      command = "tinymist.pinMain",
      arguments = { vim.v.null },
    }, { bufnr = bufnr })
  end, { desc = "[T]inymist [U]npin", noremap = true })
end

return {
  on_attach = on_attach,
  offset_encoding = "utf-8",
  settings = {
    exportPdf = "onSave",
    outputPath = "$root/target/$dir/$name",
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
  },
}
