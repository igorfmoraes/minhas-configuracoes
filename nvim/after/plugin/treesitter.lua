local ts = require("nvim-treesitter")

local parsers = { "lua", "html", "css", "javascript", "typescript", "python", "gdscript", "vue", "rust" }

ts.install(parsers)

local function is_installed(lang)
	local ok, installed = pcall(ts.get_installed, "parsers")
	return ok and vim.list_contains(installed, lang)
end

local function start(buf, lang)
	if vim.api.nvim_buf_is_valid(buf) then
		pcall(vim.treesitter.start, buf, lang)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("wandering-raven-treesitter", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang then
			return
		end

		if is_installed(lang) then
			start(args.buf, lang)
			return
		end

		local ok, available = pcall(ts.get_available)
		if ok and vim.list_contains(available, lang) then
			ts.install({ lang }):await(function()
				vim.schedule(function()
					start(args.buf, lang)
				end)
			end)
		else
			start(args.buf, lang)
		end
	end,
})
