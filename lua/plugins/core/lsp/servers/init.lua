local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig_util = require "lspconfig.util"
local lspconfig = require "lspconfig"
require "plugins.core.lsp.servers.lua"
require "plugins.core.lsp.servers.javascript"
require "plugins.core.lsp.servers.java"
require "plugins.core.lsp.servers.python"
require "plugins.core.lsp.servers.typst"
require "plugins.core.lsp.servers.php"
-- require "plugins.core.lsp.servers.bash"
require "plugins.core.lsp.servers.emmet"
require "plugins.core.lsp.servers.nix"

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

-- Setup servers with basic configuration
for _, lsp in ipairs(basic_servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- Servers with special configurations
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig_util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

lspconfig.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
  init_options = {
    clangdFileStatus = true,
    fallbackFlags = { "-std=c++11" },
  },
  formatter = "clang-format",
}

-- Merge the capabilities
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = true,
}

lspconfig.sourcekit.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "swift", "objc", "objcpp" },
}
