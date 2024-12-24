return {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	vue_language_server_path = "/etc/profiles/per-user/qmi/bin/vue-language-server",
	on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
		local opts = { noremap = true, silent = true }
		buf_set_keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
		buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
		buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
		buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
		buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
		buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		vim.diagnostic.config({ update_in_insert = true })
		client.server_capabilities.document_formatting = true
	end,
}
