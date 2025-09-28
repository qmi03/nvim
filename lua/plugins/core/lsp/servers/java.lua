local my_utils = require "plugins.core.lsp.servers.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
vim.lsp.config('jdtls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable('jdtls')

-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
--
--     -- 💀
--     'java', -- or '/path/to/java21_or_newer/bin/java'
--     -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xmx1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--
--     -- 💀
--     '-jar',
--     vim.fn.expand(
--       '/opt/homebrew/Cellar/jdtls/1.45.0/libexec/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar'),
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--     -- Must point to the                                                     Change this to
--     -- eclipse.jdt.ls installation                                           the actual version
--
--
--     -- 💀
--     '-configuration', vim.fn.expand('/opt/homebrew/Cellar/jdtls/1.45.0/libexec/config_mac/'),
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--     -- eclipse.jdt.ls installation            Depending on your system.
--
--
--     -- 💀
--     -- See `data directory configuration` section in the README
--     '-data', vim.fn.expand("/Users/qmi/.cache/jdtls/workspace/") .. project_name,
--   },
-- }
-- require('jdtls').start_or_attach(config)
