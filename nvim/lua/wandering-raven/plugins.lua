local plugins = {
	-- Appearance
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = "nvim-lua/plenary.nvim",
	},
	"shaunsingh/nord.nvim",
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},

	-- Completers
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",

	{ "williamboman/mason.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },

	-- Formatters
	{
		"stevearc/conform.nvim",
	},

	-- Navigation
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
}
require("lazy").setup(plugins, {})
