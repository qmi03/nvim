local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities

local active_lsp = "phpactor" -- change to "intelephense" if needed

-- get binary path via system call
local get_binary_path = function(name)
  local handle = io.popen("which " .. name)
  if handle then
    local result = handle:read("*l")
    handle:close()
    return result
  end
  return name
end

-- configs
local lsp_configs = {
  phpactor = function()
    vim.lsp.config("phpactor", {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        ["language_server_php_cs_fixer.enabled"] = true,
        ["language_server_php_cs_fixer.bin"] = get_binary_path "php-cs-fixer",
        ["language_server_php_cs_fixer.config"] = ".php-cs-fixer.dist.php",
        ["code_transform.import_globals"] = true,
        ["navigator.destinations"] = "{dirname}/{basename}",
        ["language_server_worse_reflection.diagnostics.enable"] = false,
        ["language_server.diagnostic_ignore_codes"] = {
          "worse.undefined_variable",
        },
      },
    })
    vim.lsp.enable("phpactor")
  end,

  intelephense = function()
    vim.lsp.config("intelephense", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          files = {
            maxSize = 1000000,
            associations = { "*.php", "*.phtml", "*.inc" },
            exclude = { "vendor", "node_modules" },
          },
          environment = {
            includePaths = { "." },
          },
          stubs = {
            "apache", "bcmath", "bz2", "calendar", "Core", "curl",
            "date", "dba", "dom", "fileinfo", "filter", "ftp", "gd",
            "gettext", "hash", "iconv", "imap", "intl", "json", "ldap",
            "libxml", "mbstring", "mysqli", "mysqlnd", "oci8",
            "openssl", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar",
            "readline", "Reflection", "session", "SimpleXML", "soap",
            "sockets", "sodium", "SPL", "standard", "superglobals",
            "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter",
            "zip", "zlib",
          },
        },
      },
    })
    vim.lsp.enable("intelephense")
  end,
}

-- activate chosen LSP
if lsp_configs[active_lsp] then
  lsp_configs[active_lsp]()
else
  print(
    "Invalid LSP selection: "
    .. active_lsp
    .. ". Available: phpactor, intelephense"
  )
end
