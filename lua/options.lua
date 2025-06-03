local opt = vim.opt -- for conciseness


opt.relativenumber = false -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.scrolloff = 4 -- scrolloff prevents cursor to hit the bottom/top, right side
opt.sidescrolloff = 4 -- same with side when wrap is off
opt.colorcolumn = "80" -- max text/code width indication
opt.signcolumn = "yes:2" -- show sign column so that text doesn't shift
opt.termguicolors = true -- turn on termguicolors for nightfly colorscheme to work

-- line wrapping
opt.wrap = true -- line wrap to see everything in the line
opt.lbr = true -- breaks at space not at a word

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- swap and undo files
opt.swapfile = true
opt.undofile = true

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- for chars that are normally not visible
opt.list = true
opt.listchars = {
    tab = "-->",
    trail = "."
}

-- backspace
opt.backspace = "indent,eol,start"
-- allow backspace on indent, end of line or insert mode start position
-- update: i have no idea what this actually does, better leave it here

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true -- show all results
opt.incsearch = true -- already highlights while searching


-- when search highlight all matches until hit enter
vim.cmd([[
    augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
    augroup END
]])

vim.api.nvim_create_autocmd({"BufNewFile"}, { command = '0r '..vim.fn.stdpath("config")..'/templates2/skeleton.'..vim.fn.expand("%:e")})


-- -----------------------------------------------------------------------------
-- Options not used

-- opt.iskeyword:append("-") -- consider string-string as whole word
-- opt.diffopt:append("vertical")
-- opt.cursorline = true -- highlight the current cursor line
