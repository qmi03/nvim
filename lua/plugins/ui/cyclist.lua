return {
  "tjdevries/cyclist.vim",
  config = function()
    -- Create autogroup for changing listchars based on filetype
    local cyclist_group =
      vim.api.nvim_create_augroup("ChangeListChars", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = cyclist_group,
      pattern = "c",
      callback = function()
        vim.fn["cyclist#activate_listchars"] "c_listchars"
      end,
    })

    -- Add named configurations
    vim.fn["cyclist#add_listchar_option_set"]("limited", {
      eol = "↲",
      tab = "» ",
      trail = "·",
      extends = "<",
      precedes = ">",
      conceal = "┊",
      nbsp = "␣",
    })

    vim.fn["cyclist#add_listchar_option_set"]("busy", {
      eol = "↲",
      tab = "»·",
      space = "␣",
      trail = "-",
      extends = "☛",
      precedes = "☚",
      conceal = "┊",
      nbsp = "☠",
    })

    -- Set up keymaps
    vim.keymap.set(
      "n",
      "<leader>cn",
      "<Plug>CyclistNext",
      { desc = "Cyclist next configuration" }
    )
    vim.keymap.set(
      "n",
      "<leader>cp",
      "<Plug>CyclistPrev",
      { desc = "Cyclist previous configuration" }
    )
  end,
}
