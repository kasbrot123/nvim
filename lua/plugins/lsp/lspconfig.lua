-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

local keymap = vim.keymap -- for conciseness


-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


-- #########################################
-- configure the lsp servers
-- -> recommendation: install via :Mason

-- configure python server
lspconfig["pyright"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

lspconfig["texlab"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

lspconfig["rust_analyzer"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

lspconfig["lemminx"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

-- configure python server
lspconfig["gopls"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

-- configure python server
lspconfig["html"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

-- configure python server
lspconfig["clangd"].setup({
    capabilities = capabilities,
    -- on_attach = on_attach, -- the keymaps are attached to that
})

-- #########################################
-- other servers which I don't need
--
-- lspconfig["jedi-language-server"].setup({
--     capabilities = capabilities,
-- --     on_attach = on_attach,
-- })

-- executable not working properly
-- lspconfig["pylsp"].setup({
--     capabilities = capabilities,
--     -- on_attach = on_attach,
-- })
--
--
-- -- configure html server
-- lspconfig["html"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure typescript server with plugin
-- typescript.setup({
--   server = {
--     capabilities = capabilities,
--     on_attach = on_attach,
--   },
-- })
--
-- -- configure css server
-- lspconfig["cssls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure tailwindcss server
-- lspconfig["tailwindcss"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })
--
-- -- configure emmet language server
-- lspconfig["emmet_ls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })
--
-- -- configure lua server (with special settings)
-- lspconfig["sumneko_lua"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = { -- custom settings for lua
--     Lua = {
--       -- make the language server recognize "vim" global
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         -- make language server aware of runtime files
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.stdpath("config") .. "/lua"] = true,
--         },
--       },
--     },
--   },
-- })
