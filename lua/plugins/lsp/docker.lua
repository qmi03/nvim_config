local qmi_lsp_config = require("lua.configs.lsp.qmi-lsp-config")
local capabilities, on_attach = qmi_lsp_config.capabilities, qmi_lsp_config.on_attach
local lspconfig = require("lspconfig")

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
lspconfig.docker_compose_language_service.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
