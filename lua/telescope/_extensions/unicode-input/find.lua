local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local results = require("telescope-unicode-input").opts.unicode

local sample_unicode = {
  { value = "ℕ", key = "bN", name = "Double-Struck Capital N" },
  { value = "→", key = "->", name = "Rightwards Arrow" },
  { value = "∸", key = ".-", name = "Dot Minus" },
  { value = "≡", key = "==", name = "Identical To" },
}

--local results = sample_unicode

M.search = function(telescope_opts)
  telescope_opts = telescope_opts or {}
  local initial_mode = vim.fn.mode()
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
            ordinal = result.key,
          }
        end,
      }),
      sorter = conf.generic_sorter(telescope_opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local output = selection.value
          vim.schedule(function()
            vim.cmd([[startinsert]])
            vim.cmd([[normal! l]])
            vim.api.nvim_put({ output }, "", false, true)
          end)
        end)
        return true
      end,
    })
    :find()
end

--M.search()

return M
