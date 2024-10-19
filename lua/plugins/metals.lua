return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
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
      client.server_capabilities.document_formatting = true
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
