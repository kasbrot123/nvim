-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    print('lspconfig plugin could not be loaded')
    return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    print('cmp_nvim_lsp plugin could not be loaded')
    return
end


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

