-- Libraries call VS Code setContext command, which is not available in Neovim, this avoids errors
vim.lsp.commands["setContext"] = function(_, _)
	return {}
end

-- pcall avoids nil errors when requiring lsp-zero fails to return a valid value
local lsp_zero_status, lsp_zero = pcall(require, "lsp-zero")
if not lsp_zero_status or not lsp_zero then
	vim.notify("lsp-zero failed to load. Check lazy.nvim setup.", vim.log.levels.ERROR)
	return
end

lsp_zero.preset("recommended")
lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"black",
		"eslint_d",
		"emmet_language_server",
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
	handlers = {
		lsp_zero.default_setup,
		ts_ls = function() end,
		vue_ls = function() end,
	},
})

-- ============================================================================================
-- TypeScript and Vue are NOT in Mason LSP Config, because I couldn't get them to work that way
-- Native LSP config bypasses nvim-lspconfig to eliminate hybrid-mode blocks
-- ============================================================================

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "vue" },
	callback = function(args)
		local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
		local vue_path = mason_packages .. "/vue-language-server"
		local ts_path = mason_packages .. "/typescript-language-server"

		if vim.fn.isdirectory(vue_path) == 0 or vim.fn.isdirectory(ts_path) == 0 then
			return
		end

		local root_dir = vim.fs.root(args.buf, { "package.json", "tsconfig.json", "jsconfig.json", ".git" })
		if not root_dir then
			root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf))
		end

		vim.lsp.start({
			name = "ts_ls",
			cmd = { "typescript-language-server", "--stdio" },
			root_dir = root_dir,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_path .. "/node_modules/@vue/language-server",
						languages = { "vue" },
					},
				},
			},
		})

		if vim.bo[args.buf].filetype == "vue" then
			vim.lsp.start({
				name = "vue_ls",
				cmd = { "vue-language-server", "--stdio" },
				root_dir = root_dir,
				init_options = {
					typescript = {
						tsdk = ts_path .. "/node_modules/typescript/lib",
					},
					vue = {
						hybridMode = true,
					},
				},
			})
		end
	end,
})

-- Godot
local port = os.getenv('GDScript_Port') or '6005'
local pipe = '/tmp/godot.pipe' 

vim.lsp.config('gdscript', {
  cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port)),
  on_attach = function(client, bufnr)
    vim.fn.serverstart(pipe)
  end
})

vim.lsp.enable('gdscript')
