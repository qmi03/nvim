vim.g.mapleader = " "
local opt = vim.opt -- for conciseness

vim.g.mapleader = " "
vim.g.background = "dark"
-- line numbers
opt.relativenumber = true
opt.number = true


-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false
vim.keymap.set("n", "<leader>ww", ":lua vim.wo.wrap = not vim.wo.wrap<CR>")

-- show vim mode (normal, command, insert,...), only do this if you have
-- mini statusline plugin installed
opt.cmdheight = 0
opt.showtabline = 0

-- textwrap at 80 cols
-- opt.tw = 80
opt.colorcolumn = "80"

-- Enable break indent
opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- highlight current line
opt.cursorline = true
vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor",                                -- No blink for normal, visual, and command modes
  "i-ci-ve:block/lCursor-blinkwait500-blinkoff500-blinkon500", -- Blink in insert modes
  "r-cr:hor20-Cursor/lCursor",                                 -- No blink for replace modes
  "o:hor50-Cursor/lCursor",                                    -- No blink for operator-pending mode
}, ",")

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "number"
-- backspace
opt.backspace = "indent,eol,start"

-- clipboard sync with OS clipboard
vim.schedule(function()
  opt.clipboard:append "unnamedplus"
end)

-- split windows
opt.splitright = true
opt.splitbelow = true

-- wildmenu
-- opt.wildmenu = true
-- opt.wildmode = "list:longest,list:full" -- don't insert, show options

-- save undo history
opt.undofile = true
-- opt.iskeyword:append "-"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

opt.swapfile = false

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Preview substitution live
opt.inccommand = "split"

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- minimal number of line below when scrolling
opt.scrolloff = 16
opt.sidescrolloff = 16

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

opt.mouse = 'a'
-- terminal esc
--
vim.diagnostic.config { update_in_insert = true }
