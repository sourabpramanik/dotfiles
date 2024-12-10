return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 3000,
		},
	},

	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local function get_git_diff()
						local icons = { removed = "", changed = "", added = "" }
						local signs = vim.b[props.buf].gitsigns_status_dict
						local labels = {}
						if signs == nil then
							return labels
						end
						for name, icon in pairs(icons) do
							if tonumber(signs[name]) and signs[name] > 0 then
								table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
							end
						end
						if #labels > 0 then
							table.insert(labels, { "┊ " })
						end
						return labels
					end

					local function get_diagnostic_label()
						local icons = { error = "", warn = "", info = "", hint = "" }
						local label = {}
						for severity, icon in pairs(icons) do
							local n = #vim.diagnostic.get(
								props.buf,
								{ severity = vim.diagnostic.severity[string.upper(severity)] }
							)
							if n > 0 then
								table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
							end
						end
						if #label > 0 then
							table.insert(label, { "┊ " })
						end
						return label
					end

					return {
						{ get_diagnostic_label() },
						{ get_git_diff() },
						{ (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
						{ filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
						{ "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
					}
				end,
			})
		end,
	},
}
