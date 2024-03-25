if vim.loader then
	vim.loader.enable()
end

require("spramanik.config.options")
require("spramanik.config.lazy")
require("spramanik.config.keymaps")
