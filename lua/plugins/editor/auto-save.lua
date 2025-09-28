return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup
    {
      enabled = true,        -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      execution_message = {
        message = function() -- message to print on save
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,                                      -- dim the color of `message`
        cleaning_interval = 200,                         -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
      trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
      -- function that determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      condition = function(buf)
        local excluded_filetypes = {
          "oil",
          "alpha",
          "NvimTree",
          "neo-tree",
          "toggleterm",
          "TelescopePrompt",
        }

        local filetype = vim.fn.getbufvar(buf, "&filetype")
        local is_modifiable = vim.fn.getbufvar(buf, "&modifiable") == 1
        local is_excluded = vim.tbl_contains(excluded_filetypes, filetype)

        return is_modifiable and not is_excluded
      end,
      write_all_buffers = false, -- write all buffers when the current one meets `condition`
      debounce_delay = 135,      -- saves the file at most every `debounce_delay` milliseconds
      callbacks = {              -- functions to be executed at different intervals
        enabling = function()
          vim.notify "Auto-save enabled"
        end,
        disabling = function()
          vim.notify "Auto-save disabled"
        end,
        before_asserting_save = nil, -- ran before checking `condition`
        before_saving = nil,         -- ran before doing the actual save
        after_saving = nil           -- ran after doing the actual save
      }
    }
  end,
}
