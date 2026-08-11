require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "html", "css", "javascript", "typescript", "python", "gdscript", "vue", "rust" },

	sync_install = false,

	-- Install missing parsers when entering buffer
	auto_install = true,

	highlight = {
		enable = true,
	},
})
