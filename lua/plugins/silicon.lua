return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	config = function()
		require("silicon").setup({
			font = "JetBrainsMonoNL Nerd Font=34;",
		})
	end,
}
