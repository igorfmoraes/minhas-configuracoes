local plugins = {
	-- Appearance
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},
	{ "shaunsingh/nord.nvim" },
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},

	-- Completers
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },

	{ "mason-org/mason.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	},

	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },

	-- Formatters
	{ "stevearc/conform.nvim" },

	-- Navigation
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
}
require("lazy").setup(plugins, {})
