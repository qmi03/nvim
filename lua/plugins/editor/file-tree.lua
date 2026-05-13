return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    -- This sets Ctrl + T to toggle the tree
    keys = {
      { "<C-t>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require('neo-tree').setup({
        window = {
          position = "right", -- Moves the tree to the right side
        },
        filesystem = {
          follow_current_file = {
            enabled = true,   -- Optional: focuses the current file in the tree
          },
          filtered_items = {
            hide_dotfiles = false, -- Optional: show hidden files
            hide_gitignored = false,
          }
        }
      })
    end
  }
}
