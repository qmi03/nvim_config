local my_utils = require "plugins.configs.lsp.utils"
local on_attach, capabilities = my_utils.on_attach, my_utils.capabilities
local lspconfig_util = require "lspconfig.util"
local lspconfig = require "lspconfig"
require "plugins.configs.lsp.lua"
require "plugins.configs.lsp.javascript"
require "plugins.configs.lsp.java"
require "plugins.configs.lsp.python"
local basic_servers = {
  "zls",
  "gleam",
  "lemminx",
  "cmake",
  "unison",
  "nil_ls",
  "taplo",
  "texlab",
  "dockerls",
  "docker_compose_language_service",
}

-- Setup servers with basic configuration
for _, lsp in ipairs(basic_servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- Servers with special configurations
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig_util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

lspconfig.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    clangdFileStatus = true,
  },
  formatter = "clang-format",
}

lspconfig.tinymist.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  offset_encoding = "utf-8",
}
-- Merge the capabilities
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = true,
}

lspconfig.sourcekit.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "swift", "objc", "objcpp" },
}
