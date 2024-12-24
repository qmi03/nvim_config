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
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local qmi_lsp_config = require("qmi-lsp-config")
			local on_attach, capabilities = qmi_lsp_config.on_attach, qmi_lsp_config.capabilities
			local lspconfig_util = require("lspconfig.util")
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								"${3rd}/luv/library",
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = {
					Lua = {},
				},
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
				filetypes = {
					"markdown",
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"json",
				},
			})

			local vue_language_server_path = "/etc/profiles/per-user/qmi/bin/vue-language-server"
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
						tsdk = "/Users/qmi/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/",
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

			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "rust" },
				root_dir = lspconfig_util.root_pattern("Cargo.toml"),
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
			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = {
					clangdFileStatus = true,
				},
				formatter = "clang-format",
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
			lspconfig.tinymist.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				offset_encoding = "utf-8",
			})
			lspconfig.texlab.setup({
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
				filetypes = { "swift", "objc", "objcpp" },
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
