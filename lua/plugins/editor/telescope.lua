return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/popup.nvim",
      "jvgrootveld/telescope-zoxide",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"
      local themes = require "telescope.themes"
      local z_utils = require "telescope._extensions.zoxide.utils"

      -- Load extensions
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
      pcall(telescope.load_extension, "file_browser")
      pcall(telescope.load_extension, "zoxide")

      -- Key mappings
      local keymaps = {
        ["ff"] = { builtin.find_files, desc = "Find files in cwd" },
        ["fh"] = { builtin.help_tags, desc = "Search help tags" },
        ["fk"] = { builtin.keymaps, desc = "Find keymaps" },
        ["fg"] = { builtin.live_grep, desc = "Live grep in cwd" },
        ["fr"] = {
          function()
            builtin.oldfiles { only_cwd = true }
          end,
          desc = "Recent files",
        },
        ["f/"] = {
          function()
            builtin.current_buffer_fuzzy_find(
              themes.get_dropdown { winblend = 12, previewer = false }
            )
          end,
          desc = "Fuzzy find in buffer",
        },
        ["fn"] = {
          function()
            builtin.find_files { cwd = vim.fn.stdpath "config" }
          end,
          desc = "Find in nvim config",
        },
        ["fgh"] = {
          function()
            builtin.live_grep { additional_args = { "--hidden", "--no-ignore" } }
          end,
          desc = "Live grep with hidden files",
        },
        ["fz"] = {
          telescope.extensions.zoxide.list,
          desc = "Zoxide directory list",
        },
        ["fs"] = {
          function()
            builtin.lsp_workspace_symbols()
          end,
          desc = "Get workspace symbols",
        }
      }

      for key, mapping in pairs(keymaps) do
        vim.keymap.set("n", key, mapping[1], { desc = mapping.desc })
      end

      -- Telescope setup
      telescope.setup {
        defaults = {
          cache_picker = { num_pickers = 12 },
          dynamic_preview_title = true,
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              width = 0.9,
              height = 0.9,
              preview_height = 0.6,
              preview_cutoff = 0,
            },
          },
          path_display = { "smart", shorten = { len = 3 } },
          wrap_results = true,
        },
        extensions = {
          file_browser = {
            layout_strategy = "horizontal",
            sorting_strategy = "ascending",
          },
          heading = { treesitter = true },
          ["ui-select"] = { themes.get_dropdown {} },
          zoxide = {
            prompt_title = "[ Walking on the shoulders of TJ ]",
            list_command = "zoxide query -ls",
            mappings = {
              default = {
                action = function(selection)
                  vim.cmd.cd(selection.path)
                end,
                after_action = function(selection)
                  print(
                    "Changed to: ("
                    .. selection.z_score
                    .. ") "
                    .. selection.path
                  )
                end,
              },
              ["<C-s>"] = {
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
              ["<C-q>"] = { action = z_utils.create_basic_command "split" },
              ["<C-v>"] = { action = z_utils.create_basic_command "vsplit" },
              ["<C-t>"] = {
                action = function(selection)
                  vim.cmd.tcd(selection.path)
                end,
              },
              ["<C-f>"] = {
                keepinsert = true,
                action = function(selection)
                  builtin.find_files { cwd = selection.path }
                end,
              },
              ["<C-b>"] = {
                keepinsert = true,
                action = function(selection)
                  telescope.extensions.file_browser.file_browser {
                    cwd = selection.path,
                  }
                end,
              },
              ["<C-x>"] = {
                action = function(selection)
                  vim.cmd "term"
                  vim.fn.chdir(selection.path)
                end,
              },
            },
          },
        },
      }
    end,
  },
}
