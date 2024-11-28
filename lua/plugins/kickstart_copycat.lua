return {

	{
		"tpope/vim-sleuth",
	},
	{
		"folke/which-key.nvim",
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			local statusline = require("mini.statusline")
			-- local animate = require("mini.animate")
			-- animate.setup()
			statusline.setup({ use_icons = vim.g.have_nerd_fonts })
			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}
