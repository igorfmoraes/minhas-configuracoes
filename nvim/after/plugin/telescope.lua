local builtin = require("telescope.builtin")

vim.keymap.set("n", "<Space>pf", builtin.find_files, {})
vim.keymap.set("n", "<Space>ff", builtin.live_grep, {})
