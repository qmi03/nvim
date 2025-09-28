local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          vim.loop.fs_stat(path .. "/.luarc.json")
          or vim.loop.fs_stat(path .. "/.luarc.jsonc")
      then
        return
      end
    end

    client.config.settings.Lua =
        vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
              -- "${3rd}/busted/library",
            },
            -- Or: vim.api.nvim_get_runtime_file("", true)
          },
        })
  end,
  settings = {
    Lua = {},
  },
})

vim.lsp.enable("lua_ls")
