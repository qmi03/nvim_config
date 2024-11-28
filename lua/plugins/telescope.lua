return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fr", function()
				builtin.oldfiles({ only_cwd = true })
			end, {})
			vim.keymap.set("n", "<leader>f/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 12,
					previewer = false,
				}))
			end, {})
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, {})
			--			vim.keymap.set("n", "<leader>ph>", function()
			--	builtin.find_files({ hidden = true, no_ignore = true })
			--		end, {})
			vim.keymap.set("n", "<leader>fgh", function()
				builtin.live_grep({
					additional_args = function(opts)
						return { "--hidden", "--no-ignore" }
					end,
				})
			end, {})
			telescope.setup({
				extensions = {
					file_browser = { layout_strategy = "horizontal", sorting_strategy = "ascending" },
					heading = { treesitter = true },
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
				defaults = {
					cache_picker = { num_pickers = 12 },
					dynamic_preview_title = true,
					layout_strategy = "vertical",
					layout_config = {
						vertical = { width = 0.9, height = 0.9, preview_height = 0.6, preview_cutoff = 0 },
					},
					path_display = { "smart", shorten = { len = 3 } },
					wrap_results = true,
				},
			})
		end,
	},
}
