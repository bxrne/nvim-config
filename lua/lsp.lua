local M = {}

function M.setup()
	local cmp = require "cmp"
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Minimal LSP + Mason
	require("mason").setup()
	require("mason-lspconfig").setup {
		ensure_installed = { "gopls", "ts_ls", "lua_ls", "pyright" },
		automatic_installation = true,
	}

	cmp.setup {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert {
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm { select = true },
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			{ name = "buffer" },
		}),
	}

	local lspconfig = require "lspconfig"

	lspconfig.gopls.setup { capabilities = capabilities }
	lspconfig.ts_ls.setup { capabilities = capabilities }
	lspconfig.lua_ls.setup { capabilities = capabilities }
	lspconfig.pyright.setup { capabilities = capabilities }


	-- Global LSP mappings
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
end

return M
