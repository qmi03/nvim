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

      vim.api.nvim_set_keymap("n", "<leader>ng", "<cmd>Neogit cwd=%:p:h<CR>", {})
      neogit.setup {
        disable_insert_on_commit = true,
        -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
        -- events.
        filewatcher = {
          interval = 100,
          enabled = true,
        },
        -- "ascii"   is the graph the git CLI generates
        -- "unicode" is the graph like https://github.com/rbong/vim-flog
        -- "kitty"   is the graph like https://github.com/isakbm/gitgraph.nvim - use https://github.com/rbong/flog-symbols if you don't use Kitty
        graph_style = "unicode",
        -- Show message with spinning animation when a git command is running.
        process_spinner = true,
        -- Change the default way of opening neogit
        kind = "tab",
        -- Floating window style
        floating = {
          relative = "editor",
          width = 0.9,
          height = 0.9,
          style = "minimal",
          border = "rounded",
        },
        commit_editor = {
          kind = "tab",
          show_staged_diff = true,
          -- Accepted values:
          -- "split" to show the staged diff below the commit editor
          -- "vsplit" to show it to the right
          -- "split_above" Like :top split
          -- "vsplit_left" like :vsplit, but open to the left
          -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
          staged_diff_split_kind = "auto",
          spell_check = true,
        },
        commit_select_view = {
          kind = "tab",
        },
        commit_view = {
          kind = "vsplit",
          verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
        },
        log_view = {
          kind = "tab",
        },
        rebase_editor = {
          kind = "auto",
        },
        reflog_view = {
          kind = "tab",
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
          kind = "tab",
        },
        refs_view = {
          kind = "tab",
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
        mappings = {
          commit_editor = {
            ["q"] = "Close",
            ["c"] = "Submit",
            ["<c-c><c-c>"] = "Abort",
            ["<m-p>"] = "PrevMessage",
            ["<m-n>"] = "NextMessage",
            ["<m-r>"] = "ResetMessage",
          },
          commit_editor_I = {
            ["<c-c><c-j>"] = "Submit",
            ["<c-c><c-c>"] = "Abort",
          },
          rebase_editor = {
            ["p"] = "Pick",
            ["r"] = "Reword",
            ["e"] = "Edit",
            ["s"] = "Squash",
            ["f"] = "Fixup",
            ["x"] = "Execute",
            ["d"] = "Drop",
            ["b"] = "Break",
            ["q"] = "Close",
            ["<cr>"] = "OpenCommit",
            ["gk"] = "MoveUp",
            ["gj"] = "MoveDown",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
            ["[c"] = "OpenOrScrollUp",
            ["]c"] = "OpenOrScrollDown",
          },
          rebase_editor_I = {
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
          },
          finder = {
            ["<cr>"] = "Select",
            ["<c-c>"] = "Close",
            ["<esc>"] = "Close",
            ["<c-n>"] = "Next",
            ["<c-p>"] = "Previous",
            ["<down>"] = "Next",
            ["<up>"] = "Previous",
            ["<tab>"] = "InsertCompletion",
            ["<c-y>"] = "CopySelection",
            ["<space>"] = "MultiselectToggleNext",
            ["<s-space>"] = "MultiselectTogglePrevious",
            ["<c-j>"] = "NOP",
            ["<ScrollWheelDown>"] = "ScrollWheelDown",
            ["<ScrollWheelUp>"] = "ScrollWheelUp",
            ["<ScrollWheelLeft>"] = "NOP",
            ["<ScrollWheelRight>"] = "NOP",
            ["<LeftMouse>"] = "MouseClick",
            ["<2-LeftMouse>"] = "NOP",
          },
          -- Setting any of these to `false` will disable the mapping.
          popup = {
            ["?"] = "HelpPopup",
            ["A"] = "CherryPickPopup",
            ["d"] = "DiffPopup",
            ["M"] = "RemotePopup",
            ["P"] = "PushPopup",
            ["X"] = "ResetPopup",
            ["Z"] = "StashPopup",
            ["i"] = "IgnorePopup",
            ["t"] = "TagPopup",
            ["b"] = "BranchPopup",
            ["B"] = "BisectPopup",
            ["w"] = "WorktreePopup",
            ["c"] = "CommitPopup",
            ["f"] = "FetchPopup",
            ["l"] = "LogPopup",
            ["m"] = "MergePopup",
            ["p"] = "PullPopup",
            ["r"] = "RebasePopup",
            ["v"] = "RevertPopup",
          },
          status = {
            ["j"] = "MoveDown",
            ["k"] = "MoveUp",
            ["o"] = "OpenTree",
            ["q"] = "Close",
            ["I"] = "InitRepo",
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["Q"] = "Command",
            ["<tab>"] = "Toggle",
            ["za"] = "Toggle",
            ["zo"] = "OpenFold",
            ["x"] = "Discard",
            ["s"] = "Stage",
            ["S"] = "StageUnstaged",
            ["<c-s>"] = "StageAll",
            ["u"] = "Unstage",
            ["K"] = "Untrack",
            ["U"] = "UnstageStaged",
            ["y"] = "ShowRefs",
            ["$"] = "CommandHistory",
            ["Y"] = "YankSelected",
            ["<c-r>"] = "RefreshBuffer",
            ["<cr>"] = "GoToFile",
            ["<s-cr>"] = "PeekFile",
            ["<c-v>"] = "VSplitOpen",
            ["<c-x>"] = "SplitOpen",
            ["<c-t>"] = "TabOpen",
            ["{"] = "GoToPreviousHunkHeader",
            ["}"] = "GoToNextHunkHeader",
            ["[c"] = "OpenOrScrollUp",
            ["]c"] = "OpenOrScrollDown",
            ["<c-k>"] = "PeekUp",
            ["<c-j>"] = "PeekDown",
            ["<c-n>"] = "NextSection",
            ["<c-p>"] = "PreviousSection",
          },
        }
      }
      -- Copy staged diff to clipboard
      vim.keymap.set('n', '<leader>yd', function()
        -- Get the staged diff using git diff --cached
        local handle = io.popen('git diff --cached')
        if not handle then
          vim.notify('Failed to execute git command', vim.log.levels.ERROR)
          return
        end

        local diff = handle:read('*all')
        handle:close()

        if diff == '' then
          vim.notify('No staged changes found', vim.log.levels.WARN)
          return
        end

        -- Copy to system clipboard
        vim.fn.setreg('+', diff)

        -- Also copy to unnamed register as backup
        vim.fn.setreg('"', diff)

        vim.notify('Staged diff copied to clipboard!', vim.log.levels.INFO)
      end, { desc = 'Copy staged diff to clipboard' })
    end
  },
}
