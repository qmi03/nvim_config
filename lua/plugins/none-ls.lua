return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- js
					-- require("none-ls.diagnostics.eslint_d"),

					-- lua
					null_ls.builtins.formatting.stylua,

					-- ruby
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.diagnostics.rubocop,

					-- nix format
					null_ls.builtins.formatting.nixpkgs_fmt,

					-- swift and c
					-- null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.swiftformat,
					-- null_ls.builtins.diagnostics.swiftlint,
					-- null_ls.builtins.diagnostics.checkmake,

					-- typst
					null_ls.builtins.formatting.typstfmt,

					-- markdown
					null_ls.builtins.formatting.markdownlint,

					-- python
					null_ls.builtins.formatting.isort,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
}
