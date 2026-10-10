-- Libraries call VS Code setContext command, which is not available in Neovim, this avoids errors
vim.lsp.commands["setContext"] = function(_, _)
	return {}
end

vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("wandering-raven-lsp-keymaps", { clear = true }),
	callback = function(event)
		local function map(modes, lhs, rhs, desc)
			vim.keymap.set(modes, lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("n", "K", vim.lsp.buf.hover, "hover")
		map("n", "gd", vim.lsp.buf.definition, "definition")
		map("n", "gD", vim.lsp.buf.declaration, "declaration")
		map("n", "gi", vim.lsp.buf.implementation, "implementation")
		map("n", "go", vim.lsp.buf.type_definition, "type definition")
		map("n", "gr", vim.lsp.buf.references, "references")
		map("n", "gs", vim.lsp.buf.signature_help, "signature help")
		map("n", "<F2>", vim.lsp.buf.rename, "rename")
		map({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end, "format")
		map({ "n", "x" }, "<F4>", vim.lsp.buf.code_action, "code action")
		map("n", "gl", vim.diagnostic.open_float, "show diagnostic")
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, "previous diagnostic")
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, "next diagnostic")
	end,
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}),
})

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"black",
		"eslint_d",
		"emmet-language-server",
		"gdscript-formatter",
		"prettierd",
		"stylua",
		"typescript-language-server",
		"vue-language-server",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"html",
		"lua_ls",
		"pyright",
		"rust_analyzer",
	},
	automatic_enable = true,
})

local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			},
		},
	},
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
})

-- Godot
local port = os.getenv("GDScript_Port") or "6005"
local pipe = "/tmp/godot.pipe"

vim.lsp.config("gdscript", {
	cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port)),
	on_attach = function(client, bufnr)
		vim.fn.serverstart(pipe)
	end,
})

vim.lsp.enable("gdscript")
