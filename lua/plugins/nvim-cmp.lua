-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    print('cmp plugin could not be loaded')
    return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
    print('luasnip plugin could not be loaded')
    return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
    print('lspkind plugin could not be loaded')
    return
end


-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"


-- -- TJ DeVries solution
-- vim.keymap.set({"i", "s"}, "<C-l>", function()
--     if luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--     end
-- end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-h>", function()
--     if luasnip.jumpable(-1) then
--         luasnip.jumpable(-1)
--     end
-- end, {silent = true})
--
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        -- ["<C-e>"] = cmp.mapping.abort(), -- close completion window

        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     -- if cmp.visible() then
        --     --     cmp.select_next_item()
        --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
        --         -- that way you will only jump inside the snippet region
        --     if luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),


    }),

    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
    }),
    -- configure lspkind for vs-code like icons
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
        }),
    },
})

