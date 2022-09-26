local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
        error("This plugin requires nvim-telescope/telescope.nvim")
end

local find = require("telescope._extensions.agda-mode.find")
return telescope.register_extension({
        setup = function(opts)
                return opts
        end,
        exports = { agda_mode = find.agda_symbols },
})
