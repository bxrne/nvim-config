vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- NOTE: Jump to problem
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- NOTE: Toggleterm
vim.keymap.set("n", "<leader>tt", "<cmd>lua require('toggleterm').toggle()<CR>", { desc = "Toggle [T]erminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle Terminal Horizontal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle Terminal Vertical" })

-- NOTE: Oil as file explorer
vim.keymap.set("n", "<leader>e", function()
	require("oil").toggle_float()
end, { desc = "Toggle Oil" })

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

-- NOTE: Copilot mappings
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Chat with current buffers" })
vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Generate tests" })
vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "Fix current buffer" })
vim.keymap.set("n", "<leader>cd", "<cmd>CopilotChatDebug<CR>", { desc = "Debug current buffer" })
