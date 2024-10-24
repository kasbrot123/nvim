-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
    print('mason plugin could not be loaded')
    return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    print('mason-lspconfig plugin could not be loaded')
    return
end

-- -- import mason-null-ls plugin safely
-- local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
-- if not mason_null_ls_status then
--     return
-- end


-- enable mason
mason.setup()

-- lsp servers
mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = {
        "pyright",
        "lemminx",
        "texlab",
        "lua_ls",
        -- "tsserver",
        -- "html",
        -- "cssls",
        -- "tailwindcss",
        -- "sumneko_lua",
        -- "emmet_ls",
        -- "jedi-language-server",
        -- "python-lsp-server",
    },
    -- auto-install configured servers (with lspconfig)
    automatic_installation = false, -- not the same as ensure_installed
})

-- linters
-- mason_null_ls.setup({
--     -- list of formatters & linters for mason to install
--     ensure_installed = {
--         -- "prettier", -- ts/js formatter
--         -- "stylua", -- lua formatter
--         -- "eslint_d", -- ts/js linter
--         -- "flake8",
--     },
--     -- auto-install configured formatters & linters (with null-ls)
--     automatic_installation = true,
-- })
