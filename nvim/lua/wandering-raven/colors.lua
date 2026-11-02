function Color()
	vim.cmd([[colorscheme nord]])
	vim.cmd([[set background=light]])
	vim.g.nord_bold = true
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	require("nord").set()
end

Color()
