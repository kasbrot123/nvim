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
  ensure_installed = {
    "html",
    "lua",
    "vim",
    "markdown",
    "bash",
    -- "gitignore",
    -- "xml",
    -- "python",
    -- "json",
    -- "javascript",
    -- "typescript",
    -- "tsx",
    -- "yaml",
    -- "css",
    -- "svelte",
    -- "graphql",
    -- "dockerfile",
  },
  -- auto install above language parsers
  auto_install = true,
})
