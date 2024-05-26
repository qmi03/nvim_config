return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
      vim.api.nvim_command("hi Normal guibg=NONE ctermbg=NONE")
    end,
  },
}
