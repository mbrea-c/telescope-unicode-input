local M = {}

M.opts = {
  unicode = {},
}

M.setup = function(opts)
  if opts.unicode ~= nil then
    M.opts.unicode = opts.unicode
  end
end

return M
