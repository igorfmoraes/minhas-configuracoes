require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		lua = { "stylua" },
		python = { "black" },
		gdscript = { "gdscript-formatter" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		rust = { "rust_analyzer" },
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_format = "fallback",
	},
})
