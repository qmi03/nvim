require "opts"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins/core" },
    { import = "plugins/editor" },
    { import = "plugins/ui" },
    { import = "plugins/tool" },
    { import = "plugins/lang" },
  },
  default = {
    lazy = true,
  },
}

-- setup these after lazy have installed the plugins
require "keymaps"
require "colorscheme"
require "lsp"
