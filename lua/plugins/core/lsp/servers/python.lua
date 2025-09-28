local utils = require "utils"
local my_utils = require "plugins.core.lsp.servers.utils"
local capabilities, on_attach = my_utils.capabilities, my_utils.on_attach

-- ruff
vim.lsp.config("ruff", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable("ruff")

-- pylsp
if utils.executable "pylsp" then
  local venv_path = os.getenv "VIRTUAL_ENV"
  local py_path
  local curr_path = utils.check_python_executable()

  if curr_path == nil or curr_path.path == nil then
    py_path = vim.g.python3_host_prog
  else
    if venv_path then
      py_path = venv_path .. "/bin/python3"
    else
      py_path = curr_path.path
    end
  end

  vim.lsp.config("pylsp", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          black = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },

          -- linter options
          pylint = { enabled = false, executable = "pylint" },
          ruff = { enabled = false },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },

          -- type checker
          pylsp_mypy = {
            enabled = true,
            overrides = {
              "--python-executable",
              py_path,
              "--ignore-missing-imports",
              false,
            },
            report_progress = true,
            live_mode = false,
          },

          -- auto-completion
          jedi_completion = { fuzzy = true },

          -- import sorting
          isort = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
  })
  vim.lsp.enable("pylsp")
else
  vim.notify("pylsp not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
