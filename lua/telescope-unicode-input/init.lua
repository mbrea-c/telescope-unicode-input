local M = {}

M.opts = {
  unicode = {},
}

M.setup = function(opts)
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
