vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 0
vim.g.embark_terminal_italics = 1
vim.g.have_nerd_font = true

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.opt.clipboard = "unnamedplus"
vim.opt.fileformat = "unix"
vim.opt.breakindent = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- WSL clipboard compatibility
if vim.fn.has "wsl" == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = "powershell.exe -c Get-Clipboard",
			["*"] = "powershell.exe -c Get-Clipboard",
		},
		cache_enabled = 0,
	}
	-- Enable Copilot MSYS compatibility
	vim.g.copilot_assume_msys = true
end
