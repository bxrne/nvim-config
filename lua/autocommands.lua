vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.isdirectory(vim.fn.argv()[1]) == 1 then
			require("oil").open(vim.fn.argv()[1])
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Check if the server supports go-to definition
		if client.server_capabilities.definitionProvider then
			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		end

		-- Check if the server supports references
		if client.server_capabilities.referencesProvider then
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		end

		-- Check if the server supports implementations
		if client.server_capabilities.implementationProvider then
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		end

		-- Check if the server supports type definitions
		if client.server_capabilities.typeDefinitionProvider then
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		end

		-- Check if the server supports document symbols
		if client.server_capabilities.documentSymbolProvider then
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		end

		-- Check if the server supports workspace symbols
		if client.server_capabilities.workspaceSymbolProvider then
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		end

		-- Check if the server supports rename
		if client.server_capabilities.renameProvider then
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		end

		-- Check if the server supports code actions
		if client.server_capabilities.codeActionProvider then
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		end

		-- Check if the server supports hover
		if client.server_capabilities.hoverProvider then
			map("K", vim.lsp.buf.hover, "Hover Documentation")
		end

		-- Check if the server supports go-to declaration
		if client.server_capabilities.declarationProvider then
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		end

		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
				end,
			})
		end

		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(true)
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
