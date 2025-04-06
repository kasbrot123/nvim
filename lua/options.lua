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
opt.scrolloff = 4
opt.colorcolumn = "80"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true -- show all results
opt.incsearch = true -- already highlights while searching

-- swap and undo files
opt.swapfile = true
opt.undofile = true

-- when search highlight all matches until hit enter
vim.cmd([[
    augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
    augroup END
]])


-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
-- opt.signcolumn = "auto:4" -- show sign column so that text doesn't shift
-- auto for gitsigns and lsp signs, -> does not work always resizes
opt.signcolumn = "yes:2" -- show sign column so that text doesn't shift
-- opt.cursorline = true -- highlight the current cursor line

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom


-- LSP diagnostics
vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    current_line_virtual_text = true,
})


-- -----------------------------------------------------------------------------
-- Options not used

-- opt.iskeyword:append("-") -- consider string-string as whole word
-- opt.diffopt:append("vertical")
