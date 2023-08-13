-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
-- vim.cmd([[ 
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

-- add list of plugins to install
return packer.startup(function(use)

    -- packer can manage itself
    use("wbthomason/packer.nvim")

    -- I dont't really know why but it is commonly used
    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

    -- Colorscheme 
    use('bluz71/vim-nightfly-colors')

    -- commenting with gc
    use("numToStr/Comment.nvim")

    -- vs-code like icons
    use("nvim-tree/nvim-web-devicons")

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    -- to get live_grep, install 'ripgrep' by apt or choco (nodejs addon for windows)
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

    -- Git integration
    use("tpope/vim-fugitive")

    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

    -- for undistracted writing
    use("junegunn/goyo.vim")

    -- terminal 
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    -- configuring lsp servers
    use("neovim/nvim-lspconfig") -- easily configure language servers

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion, connection to luasnip and cmp
    use("rafamadriz/friendly-snippets") -- useful snippets for diff. languages
    --

    -- managing & installing lsp servers, linters & formatters
    use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
    use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
    use({ "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('lspsaga').setup({})
        end,
    }) -- enhanced lsp uis

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    -- undotree for better file history, deactivate swapfiles
    use("mbbill/undotree")

    -- measure the startup time
    use("dstein64/vim-startuptime")

    -- formulas shown prettier
    use('jbyuki/nabla.nvim')


    -- same as PackerSync
    if packer_bootstrap then
        require("packer").sync()
    end


    -- -------------------------------------------------------------------------
    -- UNUSED PACKAGES

    -- colorschemes
    -- use('folke/tokyonight.nvim')
    -- use({
    --     'rose-pine/neovim',
    --     as = 'rose-pine',
    --     config = function()
    --         vim.cmd('colorscheme rose-pine')
    --     end
    -- })

    -- helps working with tags, quotes etc., did not use at all
    -- use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)

    -- probably copied from somewhere, dont need it
    -- use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance

    -- typescript lsp, dont write something in typescript
    -- use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)

    -- use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
    --
    -- use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
    --
    -- use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
    --
    -- use("szw/vim-maximizer") -- maximizes and restores current window
    --
    -- -- soft scroll
    -- use {'karb94/neoscroll.nvim', config = function()
    --     require("neoscroll").setup()
    -- end}
end)
