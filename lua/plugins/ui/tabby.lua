return {
  {
    'nanozuki/tabby.nvim',
    config = function()
      local api = require('tabby.module.api')
      local win_name = require('tabby.feature.win_name')

      local function interleave(array, separator)
        local result = {}
        for i, v in ipairs(array) do
          table.insert(result, v)
          if i < #array then
            table.insert(result, separator)
          end
        end
        return result
      end

      local function format_filename(filename, max_len)
        max_len = max_len or 20
        -- Extract the stem and extension:
        local stem, ext = filename:match("(.+)%.([^.]+)$")

        -- If there's no extension, treat the whole filename as the stem.
        if not stem then
          stem = filename
          ext = ""
        else
          ext = "." .. ext
        end

        -- If the stem exceeds the maximum length, truncate it and add ellipsis.
        if #stem > max_len then
          -- Ensure we have enough space for the ellipsis.
          local trunc_len = max_len - 1
          if trunc_len < 0 then trunc_len = 0 end
          stem = stem:sub(1, trunc_len) .. "…"
        end

        return stem .. ext
      end

      local function is_win_modified(win_id)
        if api.is_float_win(win_id) then
          return false
        end
        local bufid = vim.api.nvim_win_get_buf(win_id)
        if vim.bo[bufid].modified then
          return true
        end
        return false
      end

      local function is_tab_current_win_modified(tab)
        -- indicate if any of buffers in tab have unsaved changes
        --local win_ids = api.get_tab_wins(tab.id)
        local win_id = api.get_tab_current_win(tab.id)
        return is_win_modified(win_id)
      end

      local theme = {
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        fill = 'TabLineFill',
        tab = 'TabLine',
        current_tab = 'TabLineSel',
        current_tab_sep = 'TabLineSelSep',
        win = 'TabLine',
        focused = 'TabLineFocused',
      }
      require('tabby').setup({
        option = {
          tab_name = {
            name_fallback = function(tabid)
              local cur_win = api.get_tab_current_win(tabid)
              local name = ''
              if api.is_float_win(cur_win) then
                name = '[Floating]'
              else
                name = win_name.get(cur_win)
              end
              return name
            end,
          },
        },
        line = function(line)
          return {
            line.tabs().foreach(function(tab)
              local wins = api.get_tab_wins(tab.id)
              local modified = is_tab_current_win_modified(tab)
              return {
                {
                  '▎ ',
                  hl = tab.is_current() and theme.current_tab_sep or theme.tab,
                },
                --line.sep('▎ ', theme.sep, theme.sep),  -- don't use line.sep as it works like shit-get fg from the first group and bg from the second group, why the fuck not using one single group?
                --tab.number(),
                format_filename(tab.name()),
                modified and { '+', hl = tab.is_current() and theme.current_tab_sep or theme.tab },
                #wins > 1 and ' ◫',
                --' ',
                --tab.close_btn(''),
                tab.close_btn(' ✕'),
                ' ',
                hl = tab.is_current() and theme.current_tab or theme.tab,
                --margin = ' ',
              }
            end),
            line.spacer(),
            interleave(
              line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                return {
                  ' ',
                  {
                    format_filename(win.buf_name()),
                    is_win_modified(win.id) and '+',
                    hl = win.is_current() and theme.focused or theme.win,
                  },
                  ' ',
                  --margin = ' ',
                }
              end),
              { '|', hl = theme.win }
            ),
            --hl = theme.fill,
          }
        end,
        -- option = {}, -- setup modules' option,
      })
    end,
  },
}
