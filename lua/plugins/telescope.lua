return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
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
					cache_picker = { num_pickers = 10 },
					dynamic_preview_title = true,
					layout_strategy = "vertical",
					layout_config = {
						vertical = { width = 0.9, height = 0.9, preview_height = 0.6, preview_cutoff = 0 },
					},
					path_display = { "smart", shorten = { len = 3 } },
					wrap_results = true,
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
