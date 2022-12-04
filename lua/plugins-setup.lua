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
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

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
  use('folke/tokyonight.nvim')

  -- -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  -- -- commenting with gc
  use("numToStr/Comment.nvim")
  --
  -- -- file explorer
  use("nvim-tree/nvim-tree.lua")
  --
  -- -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")
  --
  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "cmake" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  -- for undistracted writing
  use("junegunn/goyo.vim")

  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}

  -- -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  
  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion, connection to luasnip and cmp
  use("rafamadriz/friendly-snippets") -- useful snippets for diff. languages
  --

  -- -- managing & installing lsp servers, linters & formatters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  -- use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  --
  -- -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  -- use({
  --   "nvim-treesitter/nvim-treesitter",
  --   run = function()
  --     local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
  --     ts_update()
  --   end,
  -- })

  -- auto closing
  -- use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  -- use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags


  -- use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)
  --
  -- use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  --
  -- use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
  --
  -- use("szw/vim-maximizer") -- maximizes and restores current window
  --


  -- I thing, packer will not install previous packages, if it was just installed the first time
  -- same as PackerSync
  if packer_bootstrap then
    require("packer").sync()
  end
end)
