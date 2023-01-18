-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

-- configure treesitter
treesitter.setup({
    -- enable syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = { enable = true },

    -- ensure these language parsers are installed
    -- check with TSInstallInfo
    -- install manually with TSInstall <package>
    ensure_installed = {
        -- "html",
        -- "vim",
        -- "bash",
        -- "latex",
        -- "lua",
        -- "python",
        -- "markdown",
        -- "gitignore",
        -- "xml",
    },

    -- Automatically install missing parsers when entering buffer
    auto_install = false,
})
