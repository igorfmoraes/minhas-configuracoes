require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd","prettier" },
		vue = { "prettierd","prettier" },
		lua = { "stylua" },
		python = { "black" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_fallback = true,
	},
})
