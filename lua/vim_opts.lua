local opt = vim.opt -- for conciseness

vim.g.mapleader = " "
vim.g.background = "light"
-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false
vim.keymap.set("n", "<leader>ww", ":lua vim.wo.wrap = not vim.wo.wrap<CR>")

-- show vim mode (normal, command, insert,...), only do this if you have
-- mini statusline plugin installed
opt.cmdheight = 0

-- textwrap at 80 cols
-- opt.tw = 80
opt.colorcolumn = "80"

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- highlight current line
opt.cursorline = true
vim.o.guicursor = table.concat({
	"n-v-c:block-Cursor/lCursor", -- No blink for normal, visual, and command modes
	"i-ci-ve:block/lCursor-blinkwait500-blinkoff500-blinkon500", -- Blink in insert modes
	"r-cr:hor20-Cursor/lCursor", -- No blink for replace modes
	"o:hor50-Cursor/lCursor", -- No blink for operator-pending mode
}, ",")

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- backspace
opt.backspace = "indent,eol,start"

-- clipboard sync with OS clipboard
vim.schedule(function()
	opt.clipboard:append("unnamedplus")
end)

-- split windows
opt.splitright = true
opt.splitbelow = true

-- wildmenu
-- opt.wildmenu = true
-- opt.wildmode = "list:longest,list:full" -- don't insert, show options

-- save undo history
opt.undofile = true
opt.iskeyword:append("-")

opt.updatetime = 250
opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

vim.g.have_nerd_font = true

-- cd into current directory
vim.cmd([[
  command! CdCurrDir cd %:p:h
]])
-- copy file path to clipboard
vim.cmd([[command! CopyFilePath let @+ = expand('%:p')]])

-- greatest keymap ever
vim.keymap.set("x", "<leader>p", '"_dP')

vim.g.markdown_fenced_languages = { "ts=typescript" }

-- notes: listchars
-- Preview substitution live
opt.inccommand = "split"

-- minimal number of line below when scrolling
opt.scrolloff = 12

-- diagnostic keymap
-- terminal esc

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
