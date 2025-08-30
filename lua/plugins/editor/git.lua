return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "+" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua",       -- optional
    },
    config = function()
      local neogit = require("neogit")

      vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd>Neogit<CR>", {})
      neogit.setup {
        disable_insert_on_commit = true,
        -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
        -- events.
        filewatcher = {
          interval = 500,
          enabled = true,
        },
        -- "ascii"   is the graph the git CLI generates
        -- "unicode" is the graph like https://github.com/rbong/vim-flog
        -- "kitty"   is the graph like https://github.com/isakbm/gitgraph.nvim - use https://github.com/rbong/flog-symbols if you don't use Kitty
        graph_style = "unicode",
        -- Show message with spinning animation when a git command is running.
        process_spinner = true,
        -- Change the default way of opening neogit
        kind = "replace",
        -- Floating window style
        floating = {
          relative = "editor",
          width = 0.9,
          height = 0.9,
          style = "minimal",
          border = "rounded",
        },
        commit_editor = {
          kind = "replace",
          show_staged_diff = true,
          -- Accepted values:
          -- "split" to show the staged diff below the commit editor
          -- "vsplit" to show it to the right
          -- "split_above" Like :top split
          -- "vsplit_left" like :vsplit, but open to the left
          -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
          staged_diff_split_kind = "vsplit",
          spell_check = true,
        },
        commit_select_view = {
          kind = "auto",
        },
        commit_view = {
          kind = "vsplit",
          verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
        },
        log_view = {
          kind = "auto",
        },
        rebase_editor = {
          kind = "auto",
        },
        reflog_view = {
          kind = "auto",
        },
        merge_editor = {
          kind = "auto",
        },
        preview_buffer = {
          kind = "floating_console",
        },
        popup = {
          kind = "split",
        },
        stash = {
          kind = "auto",
        },
        refs_view = {
          kind = "auto",
        },
        signs = {
          -- { CLOSED, OPENED }
          hunk = { "", "" },
          item = { ">", "v" },
          section = { ">", "v" },
        },
        -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
        integrations = {
          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
          -- The diffview integration enables the diff popup.
          --
          -- Requires you to have `sindrets/diffview.nvim` installed.
          diffview = nil,

          -- If enabled, use telescope for menu selection rather than vim.ui.select.
          -- Allows multi-select and some things that vim.ui.select doesn't.
          telescope = false,
          -- If enabled, uses fzf-lua for menu selection. If the telescope integration
          -- is also selected then telescope is used instead
          -- Requires you to have `ibhagwan/fzf-lua` installed.
          fzf_lua = nil,
          mini_pick = nil,
          snacks = nil,
        },
      }
    end
  },
}
