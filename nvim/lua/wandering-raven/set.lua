vim.opt.bh = "delete"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.shiftwidth = 4
vim.opt.shiftround = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.wrap = true

vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"

vim.opt.matchpairs = "(:),{:},[:],<:>"

vim.opt.endofline = true
vim.opt.endoffile = true
vim.opt.fixendofline = true

vim.opt.clipboard = "unnamedplus"
for _, motion in ipairs({ "d", "c" }) do
	vim.keymap.set({ "n", "x" }, motion, '"_' .. motion, { silent = true })
end
