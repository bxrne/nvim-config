
local M = {}
function M.setup()
    local cmp = require("cmp")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Mason setup
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "pyright",     -- Python type checker
            "ruff",        -- Python linter/formatter
        },
    })

    -- Configure completion
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
            ["<CR>"] = cmp.mapping.confirm { 
                select = true,
                behavior = cmp.ConfirmBehavior.Replace,
            },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        sources = {
            { name = "copilot", group_index = 2 },
            { name = "nvim_lsp", group_index = 2 },
            { name = "luasnip", group_index = 2 },
            { name = "buffer", group_index = 3 },
            { name = "path", group_index = 3 },
        },
        sorting = {
            priority_weight = 2,
        },
        formatting = {
            format = function(entry, vim_item)
                if entry.source.name == "copilot" then
                    vim_item.kind = " Copilot"
                    vim_item.kind_hl_group = "CmpItemKindCopilot"
                    return vim_item
                end
                return vim_item
            end
        },
    }

    -- Configure LSP servers
    local lspconfig = require("lspconfig")
    
    -- Python
    lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    diagnosticMode = "workspace",
                    inlayHints = {
                        variableTypes = true,
                        functionReturnTypes = true,
                    },
                },
            },
        },
    })

    -- Ruff
    lspconfig.ruff.setup({
        capabilities = capabilities,
        init_options = {
            settings = {
                lint = {
                    args = {},
                },
            },
        },
    })

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
    
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })

    -- Copilot status in lualine (optional)
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            local ok, copilot = pcall(require, "copilot")
            if ok then
                vim.defer_fn(function()
                    copilot.setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end, 100)
            end
        end,
    })
end

return M

