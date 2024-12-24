local my_utils = require "plugins.configs.lsp.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig = require "lspconfig"
lspconfig.denols.setup {
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
}

local vue_language_server_path =
  "/etc/profiles/per-user/qmi/bin/vue-language-server"
lspconfig.ts_ls.setup {
  init_options = {
    {
      plugins = {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
}
lspconfig.volar.setup {
  capabilities = capabilities,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = "/Users/qmi/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/",
    },
  },
}
lspconfig.svelte.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.emmet_language_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
