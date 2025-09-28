local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig_util = require "lspconfig.util"

-- load your custom server configs
require "plugins.core.lsp.servers.lua"
require "plugins.core.lsp.servers.javascript"
require "plugins.core.lsp.servers.java"
require "plugins.core.lsp.servers.python"
require "plugins.core.lsp.servers.typst"
require "plugins.core.lsp.servers.php"
-- require "plugins.core.lsp.servers.bash"
require "plugins.core.lsp.servers.emmet"
require "plugins.core.lsp.servers.nix"

-- basic servers
local basic_servers = {
  "zls",
  "gleam",
  "lemminx",
  "gopls",
  "cmake",
  "unison",
  "taplo",
  "texlab",
  "dockerls",
  "docker_compose_language_service",
}

for _, server in ipairs(basic_servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach,
  })
  vim.lsp.enable(server)
end

-- rust analyzer
vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig_util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
    },
  },
})
vim.lsp.enable("rust_analyzer")

-- clangd
vim.lsp.config("clangd", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
  init_options = {
    clangdFileStatus = true,
    fallbackFlags = { "-std=c++11" },
  },
  formatter = "clang-format",
})
vim.lsp.enable("clangd")

-- merge capabilities
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = true,
}

-- sourcekit
vim.lsp.config("sourcekit", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "swift", "objc", "objcpp" },
})
vim.lsp.enable("sourcekit")
