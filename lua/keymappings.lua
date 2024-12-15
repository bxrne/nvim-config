vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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

-- NOTE: coc.nvim key mappings
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { desc = "Go to definition" })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { desc = "Go to references" })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { desc = "Go to implementation" })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { desc = "Go to type definition" })
vim.keymap.set("n", "K",  "<cmd>call CocActionAsync('doHover')<CR>", { desc = "Show documentation" })
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", "<Plug>(coc-codeaction)", { desc = "Code action" })
vim.keymap.set("n", "<leader>dn", "<Plug>(coc-diagnostic-next)", { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>dp", "<Plug>(coc-diagnostic-prev)", { desc = "Go to previous diagnostic message" })
