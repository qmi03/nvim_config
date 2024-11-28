return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				auto_install = true,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				auto_install = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local utils = require("utils")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"
			local on_attach = function(client, bufnr)
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
			end
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.zls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.gleam.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.denols.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})

			lspconfig.ts_ls.setup({
				init_options = {
					{
						plugins = {
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				capabilities = capabilities,
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			})
			lspconfig.volar.setup({
				capabilities = capabilities,
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
					typescript = {
						tsdk = "/Users/phamvoquangminh/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/",
					},
				},
			})
			lspconfig.svelte.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.emmet_language_server.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.ruff.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			if utils.executable("pylsp") then
				local venv_path = os.getenv("VIRTUAL_ENV")
				local py_path = nil
				local curr_path = utils.check_python_executable()
				if curr_path == nil or curr_path.path == nil then
					py_path = vim.g.python3_host_prog
				else -- decide which Python executable to use for mypy
					if venv_path then
						py_path = venv_path .. "/bin/python3"
					else
						py_path = curr_path.path
					end
				end
				lspconfig.pylsp.setup({
					on_attach = on_attach,
					settings = {
						pylsp = {
							plugins = {
								-- formatter options
								black = { enabled = false },
								autopep8 = { enabled = false },
								yapf = { enabled = false },
								-- linter options
								-- wait for ruff to be stable for both linting and formatting then I'll be replacing black and pylint with ruff
								pylint = { enabled = false, executable = "pylint" },
								ruff = { enabled = false },
								pyflakes = { enabled = false },
								pycodestyle = { enabled = false },
								-- type checker
								pylsp_mypy = {
									enabled = true,
									overrides = { "--python-executable", py_path, "--ignore-missing-imports", false },
									report_progress = true,
									live_mode = false,
								},
								-- auto-completion options
								jedi_completion = { fuzzy = true },
								-- import sorting
								isort = { enabled = true },
							},
						},
					},
					flags = {
						debounce_text_changes = 200,
					},
					capabilities = capabilities,
				})
			else
				vim.notify("pylsp not found!", vim.log.levels.WARN, { title = "Nvim-config" })
			end
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "rust" },
				root_dir = util.root_pattern("Cargo.toml"),
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
					},
				},
			})
			lspconfig.lemminx.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.cmake.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- lspconfig.clangd.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--header-insertion=never",
			-- 		"--query-driver=/usr/bin/clang++,/nix/store/3r1g247lp1hk7azfsnp9jyzsj4s4b4y2-mpich-4.2.3/bin/mpicc",
			-- 	}, -- Adjust driver paths as needed
			-- 	init_options = {
			-- 		clangdFileStatus = true,
			-- 	},
			-- 	settings = {
			-- 		clangd = {
			-- 			arguments = { "-I/nix/store/3r1g247lp1hk7azfsnp9jyzsj4s4b4y2-mpich-4.2.3/include" }, -- Include path for MPICH headers
			-- 		},
			-- 	},
			-- 	formatter = "clang-format",
			-- })
			lspconfig.sourcekit.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.unison.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.nil_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.taplo.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- Merge the capabilities
			capabilities.workspace = capabilities.workspace or {}
			capabilities.workspace.didChangeWatchedFiles = {
				dynamicRegistration = true,
			}

			lspconfig.sourcekit.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
			vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rust_autosave = 1
		end,
	},
}
