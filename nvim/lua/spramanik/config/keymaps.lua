local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

keymap.set("n", "<Leader>l", ":Lazy<Return>")

keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "<C-m>", "<C-i>", opts)

keymap.set("n", "te", ":tabedit<Return>")
keymap.set("n", "tn", ":tabnew<Return>")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<b-tab>", ":tabprev<Return>", opts)

keymap.set("n", "wsh", ":split<Return>", opts)
keymap.set("n", "wsv", ":vsplit<Return>", opts)

keymap.set("n", "wh", "<C-w>h")
keymap.set("n", "wk", "<C-w>k")
keymap.set("n", "wj", "<C-w>j")
keymap.set("n", "wl", "<C-w>l")

keymap.set("n", "w<left>", "<C-w><")
keymap.set("n", "w<right>", "<C-w>>")
keymap.set("n", "w<up>", "<C-w>+")
keymap.set("n", "w<down>", "<C-w>-")

keymap.set("n", "<Leader>rn", ":IncRename ")

keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)


keymap.set("n", "<leader>gg", ":Git<Return>")
