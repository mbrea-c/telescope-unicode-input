local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local results = require("telescope-unicode-input").opts.unicode

M.search = function(telescope_opts)
  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 3 },
      { width = 10 },
      { remaining = true },
    },
  })
  local make_display = function(entry)
    return displayer({
      entry.value,
      entry.key,
      entry.name,
    })
  end
  pickers
    .new(telescope_opts, {
      prompt_title = "telescope-agda-symbols",
      finder = finders.new_table({
        results = results,
        entry_maker = function(result)
          return {
            value = result.value,
            name = result.name,
            key = result.key,
            display = make_display,
            ordinal = result.key .. result.name,
          }
        end,
      }),
      sorter = sorters.get_generic_fuzzy_sorter(telescope_opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          local output = selection.value
          local pos = vim.api.nvim_win_get_cursor(0)
          vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2], pos[1] - 1, pos[2], { output })
          vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + 2 })
        end)
        return true
      end,
    })
    :find()
end

return M
