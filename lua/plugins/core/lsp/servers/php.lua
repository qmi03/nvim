local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig = require "lspconfig"

local active_lsp = "phpactor" -- Change this to "phpactor" to use phpactor instead

-- Simple function to get the path of a binary using vim's system call
local get_binary_path = function(name)
  local handle = io.popen("which " .. name)
  if handle then
    local result = handle:read "*l"
    handle:close()
    return result
  end
  return name
end

-- Define LSP configurations in a table
local lsp_configs = {
  phpactor = function()
    lspconfig.phpactor.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        -- ["language_server_phpstan.enabled"] = false,
        -- ["language_server_psalm.enabled"] = false,
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
    }
  end,
  intelephense = function()
    lspconfig.intelephense.setup {
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
            "apache",
            "bcmath",
            "bz2",
            "calendar",
            "Core",
            "curl",
            "date",
            "dba",
            "dom",
            "fileinfo",
            "filter",
            "ftp",
            "gd",
            "gettext",
            "hash",
            "iconv",
            "imap",
            "intl",
            "json",
            "ldap",
            "libxml",
            "mbstring",
            "mysqli",
            "mysqlnd",
            "oci8",
            "openssl",
            "pcntl",
            "pcre",
            "PDO",
            "pdo_mysql",
            "Phar",
            "readline",
            "Reflection",
            "session",
            "SimpleXML",
            "soap",
            "sockets",
            "sodium",
            "SPL",
            "standard",
            "superglobals",
            "tokenizer",
            "xml",
            "xmlreader",
            "xmlrpc",
            "xmlwriter",
            "zip",
            "zlib",
          },
        },
      },
    }
  end,
}

-- Set up the chosen LSP
if lsp_configs[active_lsp] then
  lsp_configs[active_lsp]()
else
  print(
    "Invalid LSP selection: "
      .. active_lsp
      .. ". Available options: phpactor, intelephense"
  )
end
