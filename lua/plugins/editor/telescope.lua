return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.8",
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
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"
      local themes = require "telescope.themes"
      local z_utils = require "telescope._extensions.zoxide.utils"
      local Layout = require "nui.layout"
      local Popup = require "nui.popup"
      local TSLayout = require("telescope.pickers").layout
      local function make_popup(options)
        local popup = Popup(options)
        function popup.border:change_title(title)
          popup.border.set_text(popup.border, "top", title)
        end

        return TSLayout.Window(popup)
      end
      -- Load extensions
      telescope.load_extension "fzf"
      telescope.load_extension "ui-select"
      telescope.load_extension "file_browser"
      telescope.load_extension "zoxide"

      -- Key mappings
      local keymaps = {
        ["ft"] = { builtin.builtin, desc = "Open telescope builtin menu" },
        ["ff"] = { builtin.find_files, desc = "Find files in cwd" },
        ["fh"] = { builtin.help_tags, desc = "Search help tags" },
        ["fk"] = { builtin.keymaps, desc = "Find keymaps" },
        ["fg"] = { builtin.live_grep, desc = "Live grep in cwd" },
        ["frr"] = { builtin.resume, desc = "Resume" },
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
          builtin.lsp_workspace_symbols,
          desc = "Get workspace symbols",
        },
        ["fb"] = {
          builtin.buffers,
          desc = "Lists open buffers in current neovim instance",
        },
      }

      for key, mapping in pairs(keymaps) do
        vim.keymap.set("n", key, mapping[1], { desc = mapping.desc })
      end

      -- Telescope setup
      telescope.setup {
        defaults = {
          cache_picker = { num_pickers = 12 },
          dynamic_preview_title = true,
          layout_strategy = "flex",
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 120,
            },
            vertical = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 40,
            },
          },
          create_layout = function(picker)
            local border = {
              results = {
                top_left = "┌",
                top = "─",
                top_right = "┬",
                right = "│",
                bottom_right = "",
                bottom = "",
                bottom_left = "",
                left = "│",
              },
              results_patch = {
                minimal = {
                  top_left = "┌",
                  top_right = "┐",
                },
                horizontal = {
                  top_left = "┌",
                  top_right = "┬",
                },
                vertical = {
                  top_left = "├",
                  top_right = "┤",
                },
              },
              prompt = {
                top_left = "├",
                top = "─",
                top_right = "┤",
                right = "│",
                bottom_right = "┘",
                bottom = "─",
                bottom_left = "└",
                left = "│",
              },
              prompt_patch = {
                minimal = {
                  bottom_right = "┘",
                },
                horizontal = {
                  bottom_right = "┴",
                },
                vertical = {
                  bottom_right = "┘",
                },
              },
              preview = {
                top_left = "┌",
                top = "─",
                top_right = "┐",
                right = "│",
                bottom_right = "┘",
                bottom = "─",
                bottom_left = "└",
                left = "│",
              },
              preview_patch = {
                minimal = {},
                horizontal = {
                  bottom = "─",
                  bottom_left = "",
                  bottom_right = "┘",
                  left = "",
                  top_left = "",
                },
                vertical = {
                  bottom = "",
                  bottom_left = "",
                  bottom_right = "",
                  left = "│",
                  top_left = "┌",
                },
              },
            }

            local results = make_popup {
              focusable = false,
              border = {
                style = border.results,
                text = {
                  top = picker.results_title,
                  top_align = "center",
                },
              },
              win_options = {
                winhighlight = "Normal:Normal",
              },
            }

            local prompt = make_popup {
              enter = true,
              border = {
                style = border.prompt,
                text = {
                  top = picker.prompt_title,
                  top_align = "center",
                },
              },
              win_options = {
                winhighlight = "Normal:Normal",
              },
            }

            local preview = make_popup {
              focusable = false,
              border = {
                style = border.preview,
                text = {
                  top = picker.preview_title,
                  top_align = "center",
                },
              },
            }

            local box_by_kind = {
              vertical = Layout.Box({
                Layout.Box(preview, { grow = 1 }),
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 3 }),
              }, { dir = "col" }),
              horizontal = Layout.Box({
                Layout.Box({
                  Layout.Box(results, { grow = 1 }),
                  Layout.Box(prompt, { size = 3 }),
                }, { dir = "col", size = "50%" }),
                Layout.Box(preview, { size = "50%" }),
              }, { dir = "row" }),
              minimal = Layout.Box({
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 3 }),
              }, { dir = "col" }),
            }

            local function get_box()
              local strategy = picker.layout_strategy
              if strategy == "vertical" or strategy == "horizontal" then
                return box_by_kind[strategy], strategy
              end

              local height, width = vim.o.lines, vim.o.columns
              local box_kind = "horizontal"
              if width < 100 then
                box_kind = "vertical"
                if height < 40 then
                  box_kind = "minimal"
                end
              end
              return box_by_kind[box_kind], box_kind
            end

            local function prepare_layout_parts(layout, box_type)
              layout.results = results
              results.border:set_style(border.results_patch[box_type])

              layout.prompt = prompt
              prompt.border:set_style(border.prompt_patch[box_type])

              if box_type == "minimal" then
                layout.preview = nil
              else
                layout.preview = preview
                preview.border:set_style(border.preview_patch[box_type])
              end
            end

            local function get_layout_size(box_kind)
              local config =
                picker.layout_config[box_kind == "minimal" and "vertical" or box_kind]
              return {
                width = config.width,
                height = config.height,
              }
            end

            local box, box_kind = get_box()
            local layout = Layout({
              relative = "editor",
              position = "50%",
              size = get_layout_size(box_kind),
            }, box)

            layout.picker = picker
            prepare_layout_parts(layout, box_kind)

            local layout_update = layout.update
            function layout:update()
              local box, box_kind = get_box()
              prepare_layout_parts(layout, box_kind)
              layout_update(self, { size = get_layout_size(box_kind) }, box)
            end

            return TSLayout(layout)
          end,
          path_display = { "smart", shorten = { len = 2 } },
          wrap_results = true,
          mappings = {
            i = {
              ["<C-u>"] = false,
            },
            n = {
              ["l"] = require("telescope.actions").cycle_history_next,
              ["h"] = require("telescope.actions").cycle_history_prev,
            },
          },
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
