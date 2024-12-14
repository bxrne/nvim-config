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
	{ "akinsho/toggleterm.nvim", version = "*", config = true, opts = { direction = "float" } },
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
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup {
				flavour = "mocha",
			}
			vim.cmd.colorscheme "catppuccin"
		end,
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
			current_line_blame = false,
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
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require "lspconfig"
			local mason_lspconfig = require "mason-lspconfig"
			local mason_tool_installer = require "mason-tool-installer"

			local servers = {
				"lua_ls",
				"gopls",
			}

			require("mason").setup()

			mason_tool_installer.setup {
				ensure_installed = servers,
				auto_update = true,
				run_on_start = true,
			}

			mason_lspconfig.setup {
				ensure_installed = servers,
				automatic_installation = true,
			}

			for _, server in ipairs(servers) do
				lspconfig[server].setup {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				}
			end
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require "cmp"
			local luasnip = require "luasnip"
			luasnip.config.setup {}

			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert {
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm { select = true },
					["<C-Space>"] = cmp.mapping.complete {},
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			}
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
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
			context = "git",
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
	-- Add lualine.nvim for an enhanced statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "echasnovski/mini.nvim" },
		opts = {
			options = {
				theme = "catppuccin",
				component_separators = "|",
				section_separators = "",
				icons_enabled = true,
			},
		},
	},
}
