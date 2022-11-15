local M = {}

local default = function()
  return {
    unicode = {},
  }
end

M.opts = default()

M.setup = function(opts)
  M.opts = default()

  if opts.unicode ~= nil then
    for _, entry in ipairs(opts.unicode) do
      if entry.key ~= nil then
        table.insert(M.opts.unicode, entry)
      elseif entry.keys ~= nil then
        for _, key in ipairs(entry.keys) do
          table.insert(M.opts.unicode, { value = entry.value, key = key, name = entry.name })
        end
      end
    end
  end
end

return M
