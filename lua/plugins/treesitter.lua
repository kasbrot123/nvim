-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    print('nvim-treesitter.configs plugin could not be loaded')
    return
end

-- local status, treesitter_compiler = pcall(require, "nvim-treesitter.compiler")
-- if not status then
--     print("treesitter compiler not working")
--     return
-- end
--
-- print("compiler working")

-- treesitter_compiler.compilers = {"gcc"}

-- configure treesitter
treesitter.setup({
    highlight = {
        enable = true, -- enable syntax highlighting
    },

    indent = { 
        enable = true, -- enable indentation
    },

    autotag = {
        enable = true, -- enable autotagging (w/ nvim-ts-autotag plugin)
    },

    -- ensure these language parsers are installed
    -- check with TSInstallInfo
    -- install manually with TSInstall <package>

    -- to preinstall gcc must be supported, and on windows it is typically not
    ensure_installed = {
        -- "html",
        -- "vim",
        -- "bash",
        -- "latex",
        -- "lua",
        -- "python",
        -- "markdown",
        -- "gitignore",
        -- "xml"
    },

    -- Automatically install missing parsers when entering buffer
    -- autoinstall does not work smoothly so it is disabled
    auto_install = false,
})
