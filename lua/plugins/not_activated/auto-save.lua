return {
  "Pocco81/auto-save.nvim",
  opts = {
    enabled = false,
    execution_message = {
      message = function() return "Auto saved" end,
      dim = 0.18,
      cleaning_interval = 500,
    },
    trigger_events = { "InsertLeave", "TextChanged" },
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")
      if
          fn.getbufvar(buf, "&modifiable") == 1 and
          utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
        return true
      end
      return false
    end,
    write_all_buffers = false,
    debounce_delay = 135,
    callbacks = {
      enabling = function() vim.notify("Auto-save enabled") end,
      disabling = function() vim.notify("Auto-save disabled") end,
      before_asserting_save = nil,
      before_saving = nil,
      after_saving = nil
    }
  },
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", { desc = "Toggle AutoSave" })
    -- vim.defer_fn(function()
    --   vim.cmd("ASToggle")
    -- end, 500)
  end
}
