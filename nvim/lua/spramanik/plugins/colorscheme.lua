return {
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    config = function()
	    require('kanagawa').setup {
        transparent = true
    }
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
	    vim.cmd("colorscheme kanagawa-dragon")
    end
  }
}
