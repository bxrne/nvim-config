local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
	"tpope/vim-sleuth", -- NOTE: auto-detect indent settings
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"https://git.sr.ht/~nedia/auto-save.nvim",
		event = { "BufReadPre" },
		opts = {
			events = { "InsertLeave", "BufLeave" },
			silent = true,
		},
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "echasnovski/mini.nvim" },
		config = function()
			local startify = require "alpha.themes.startify"
			startify.file_icons.provider = "mini"
			require("alpha").setup(startify.config)
		end,
	},
{ 
	"rose-pine/neovim", 
	name = "rose-pine",
		opts= {
			variant = "main",
			dark_variant = "main",
		},
	config = function()
		vim.cmd("colorscheme rose-pine")
	end
},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		branch = "harpoon2",
		init = function()
			local harpoon = require "harpoon"
			harpoon:setup()
		end,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		lsp = {
			hover = { enabled = true },
			signature_help = { enabled = true },
			stylize_markdown = true,
			documentation = true,
		},

		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.nvim" },
		config = function()
			require("oil").setup {
				default_file_explorer = true,
				skip_confirm_for_simple_edits = true,
				watch_for_changes = true,
				view_options = {
					show_hidden = true,
					is_hidden_file = function(name, _)
						return vim.startswith(name, ".")
					end,
					is_always_hidden = function(_, _)
						return false
					end,
				},
				float = {
					max_width = 50,
					max_height = 30,
					preview_split = "right",
					override = function(conf)
						return conf
					end,
				},
			}

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = false
			vim.g.copilot_context = "git"
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {

			signs_staged_enable = true,
			signcolumn = true,
			numhl = true,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = true, -- Enable git blame for current line
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable "make" == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "echasnovski/mini.nvim" },
		},
		config = function()
			require("telescope").setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			}
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require "telescope.builtin"
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
					winblend = 10,
					previewer = true,
				})
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				}
			end, { desc = "[S]earch [/] in Open Files" })

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files { cwd = vim.fn.stdpath "config" }
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
			"neoclide/coc.nvim",
			branch = "release",
			event = "VimEnter",
	},
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format { async = true, lsp_fallback = true }
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = true,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				groovy = { "groovyformatter" },
				ruby = { "rubocop" },
			},
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		build = "make tiktoken",
		opts = {
			show_help = false,
			debug = false,
			disable_extra_info = "yes",
			language = "English",
			temperature = 1,
			model = "gpt-4o",
			agent = "copilot",
			system_prompt = "You are a principal engineer with 25 years of experience in the software engineering domain. When generating code, adhere to DRY, KISS, YAGNI and SOLID principles. Leverage data structures and algorithms and discrete mathematics to get more performant or elegant solutions. Ensure code is well commented and include INFO:, WARN:, TEST: prefixes to comments where appropriate (test cases or why something is so - not what). Use Gen Z slang. You are devoid of mediocrity. The output should follow this template where requirements are both functional and non functional, the approach is the method of solving and further for more options: Reqs: <list> \n Approach: <list> \n Further: - Generate tests  - Review code  - Explain code",
			auto_insert_mode = true,
			insert_at_end = true,
			question_header = "[USER] ",
			answer_header = "[LLM] ",
			err_header = "[ERR] ",
			context = "files",
			allow_insecure = true,
			window = {
				layout = "float",
				border = "single",
				width = 0.5,
				height = 0.75,
				title = "LLM",
			},
		},
		event = "VeryLazy",
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
				"go",
				"typescript",
				"yaml",
				"java",
				"cpp",
				"json",
				"python",
				"rust",
				"ruby",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
	 options = {
    theme = "rose-pine",
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
		sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {
      '%=', --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
	},
},
	{
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_view_method = 'skim'
			vim.g.vimtex_compiler_method = 'latexmk'
			vim.g.vimtex_syntax_enabled = 0 -- Disable vimtex syntax to avoid conflict with TreeSitter
		end,
	},
}
