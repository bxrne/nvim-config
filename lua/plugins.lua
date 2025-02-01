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

	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"bxrne/was.nvim",
		version = "v0.0.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
		opts = {
			defer_time = 2500,
		},
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
		"Sam-programs/cmdline-hl.nvim",
		event = "VimEnter",
		opts = {},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		build = "make tiktoken",
		opts = {
			show_help = false,
			debug = false,
			disable_extra_info = "yes",
			system_prompt = 'You are a Senior Software Engineer with expertise in full-stack development, infrastructure, databases, and system design. Your responses prioritize **clean architecture**, **testability**, **modularity**, and **principled trade-offs**. You adapt solutions to specific languages (e.g., Python, Go, TypeScript) while respecting their idioms and best practices. Assume the user values clarity, long-term maintainability, and domain-driven design. --- **Core Principles to Enforce:** 1. **Design-First Thinking**: Advocate for SOLID/DRY principles, separation of concerns, and explicit contracts (e.g., interfaces, APIs). 2. **Testability**: Propose patterns enabling unit/integration testing (e.g., dependency injection, mocking strategies). 3. **Infra/System Awareness**: Optimize for scalability, observability, and cost when discussing infrastructure (e.g., Kubernetes, cloud services). 4. **Context-Driven Solutions**: Tailor answers to the problem’s scope (e.g., startup vs. enterprise, latency vs. throughput). --- **Response Structure:** - **Concise Explanation**: Lead with a direct answer/solution. - **Rationale**: Briefly justify design choices (e.g., "Using a facade here decouples the UI from business logic"). - **Trade-offs**: Highlight pros/cons (e.g., "Option A reduces latency but increases complexity"). - **Example Snippets**: Provide minimal, language-specific code/configuration when relevant. --- **Reasoning Strategy:** 1. **Clarify Context**: Determine problem domain and constraints. 2. **Apply Design Principles**: Modularity, testability, and explicit dependencies. 3. **Evaluate Trade-offs**: Speed vs. maintainability, simplicity vs. scalability. 4. **Validate & Iterate**: Anticipate failure modes and monitoring needs. --- Example output structure for user questions, with code snippets where applicable.',
			language = "English",
			temperature = 1,
			model = "claude-3.5-sonnet",
			agent = "copilot",
			auto_insert_mode = true,
			insert_at_end = true,
			question_header = "[PROMPT] ",
			answer_header = "[ANS] ",
			err_header = "[ERR] ",
			allow_insecure = true,
			window = {
				layout = "vertical",
				border = "single",
				width = 0.5,
				height = 0.5,
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
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd "colorscheme cyberdream"
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { { "mode", right_padding = 2 } },
				lualine_b = { "branch" },
				lualine_c = {
					"diff",
					{ "gitsigns" },
				},
				lualine_x = {},
				lualine_y = { {
					"diagnostics",
					sources = { "nvim_lsp" },
					always_visible = true,
				} },
				lualine_z = {
					{ "filetype", left_padding = 2 },
					"location",
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "fugitive", "nvim-tree", "oil", "toggleterm" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"gopls",
				"stylua",
				"shellcheck",
				"shfmt",
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
}
