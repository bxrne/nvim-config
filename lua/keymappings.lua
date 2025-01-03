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

-- NOTE: Tab management key mappings
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "[T]ab [Q]uit" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "[T]ab [O]nly" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "[T]ab [L]ast" })
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "[T]ab [H]ome" })
vim.keymap.set("n", "<leader>tm", "<cmd>tabmove<CR>", { desc = "[T]ab [M]ove" })
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-1>", "1gt", { desc = "Go to tab 1" })
vim.keymap.set("n", "<C-2>", "2gt", { desc = "Go to tab 2" })
vim.keymap.set("n", "<C-3>", "3gt", { desc = "Go to tab 3" })
vim.keymap.set("n", "<C-4>", "4gt", { desc = "Go to tab 4" })
vim.keymap.set("n", "<C-5>", "5gt", { desc = "Go to tab 5" })
vim.keymap.set("n", "<C-6>", "6gt", { desc = "Go to tab 6" })
vim.keymap.set("n", "<C-7>", "7gt", { desc = "Go to tab 7" })
vim.keymap.set("n", "<C-8>", "8gt", { desc = "Go to tab 8" })
vim.keymap.set("n", "<C-9>", "9gt", { desc = "Go to tab 9" })
