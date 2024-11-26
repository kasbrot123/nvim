local opt = vim.opt -- for conciseness


-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true
opt.lbr = true

-- for chars that are normally not visible
opt.list = true
opt.listchars = {
    tab = "-->",
    trail = "."
}


-- scrolloff prevents cursor to hit the bottom/top
opt.scrolloff = 6
opt.colorcolumn = "80"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = false
opt.incsearch = true

opt.swapfile = true
opt.undofile = true


vim.cmd([[
    augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
    augroup END
]])

-- cursor line
-- opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- opt.iskeyword:append("-") -- consider string-string as whole word

opt.diffopt:append("vertical")


-- vim.api.nvim_create_autocmd("User", {
--   pattern = "TelescopePreviewerLoaded",
--   callback = function(args)
--     if args.data.filetype ~= "help" then
--       vim.wo.number = true
--     elseif args.data.bufname:match("*.png") then
--       vim.wo.wrap = false
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd({"FileType"}, { pattern="markdown", group=optional_group, command="TSDisable highlight"})
--
-- vim.api.nvim_create_autocmd({"FileType"}, { pattern={"*.md", "*.c"}, group=optional_group, command="TSDisable highlight"})


-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--     pattern = {"*.c", "*.h"},
--     callback = function(ev)
--         print(string.format('event fired: %s', vim.inspect(ev)))
--     end
-- })
--
--
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.c", "*.h"},
--   command = "echo 'Entering a C or C++ file'",
-- })
