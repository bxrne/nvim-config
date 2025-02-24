-- NOTE: Toggleterm
vim.keymap.set("n", "<leader>tt", "<cmd>lua require('toggleterm').toggle()<CR>", { desc = "Toggle [T]erminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle Terminal Horizontal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle Terminal Vertical" })

vim.keymap.set("n", "<space>e", function()
	require("telescope").extensions.file_browser.file_browser()
end)

-- indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
-- NOTE: Telescope keymappings
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { desc = "Grep files" })
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<CR>", { desc = "Commands" })
vim.keymap.set("n", "<leader>fw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", { desc = "Grep word" })

-- NOTE: Harpoon keymappings
vim.keymap.set("n", "<leader>a", function()
	require("harpoon"):list():add()
end)

vim.keymap.set("n", "<leader>h", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)

vim.keymap.set("n", "<leader>hr", function()
	require("harpoon"):list():remove()
end)

vim.keymap.set("n", "<leader>hc", function()
	require("harpoon"):list():clear()
end)

vim.keymap.set("n", "<leader>1", function()
	require("harpoon"):list():select(1)
end)

vim.keymap.set("n", "<leader>2", function()
	require("harpoon"):list():select(2)
end)

vim.keymap.set("n", "<leader>3", function()
	require("harpoon"):list():select(3)
end)

vim.keymap.set("n", "<leader>5", function()
	require("harpoon"):list():select(4)
end)

vim.keymap.set("n", "<leader>hp", function()
	require("harpoon"):list():prev()
end)
vim.keymap.set("n", "<leader>hn", function()
	require("harpoon"):list():next()
end)

vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Chat with current buffers" })
vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Generate tests" })
vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "Fix current buffer" })
vim.keymap.set("n", "<leader>cd", "<cmd>CopilotChatDebug<CR>", { desc = "Debug current buffer" })
