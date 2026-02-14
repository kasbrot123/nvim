local opt = vim.opt -- for conciseness


opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.tabstop = 4 -- 4 is best
opt.shiftwidth = 4
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.scrolloff = 4 -- scrolloff prevents cursor to hit the bottom/top, right side
opt.sidescrolloff = 4 -- same with side when wrap is off
opt.colorcolumn = "80" -- max text/code width indication
opt.signcolumn = "yes:2" -- show sign column so that text doesn't shift
opt.termguicolors = true -- turn on termguicolors for nightfly colorscheme to work
opt.wrap = true -- line wrap to see everything in the line
opt.lbr = true -- breaks at space not at a word
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
opt.swapfile = false -- was practical for server
opt.undofile = true -- 
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.list = true -- shows invisible chars
opt.listchars = { tab = "-->", trail = "." } -- shows tabs and spaces
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true -- show all results
opt.incsearch = true -- already highlights while searching


-- backspace
opt.backspace = "indent,eol,start"
-- allow backspace on indent, end of line or insert mode start position
-- update: i have no idea what this actually does, better leave it here



-- -----------------------------------------------------------------------------
-- Options not used

-- when search highlight all matches until hit enter
-- vim.cmd([[
--     augroup vimrc-incsearch-highlight
--     autocmd!
--     autocmd CmdlineEnter /,\? :set hlsearch
--     autocmd CmdlineLeave /,\? :set nohlsearch
--     augroup END
-- ]])


-- opt.iskeyword:append("-") -- consider string-string as whole word
-- opt.diffopt:append("vertical")
-- opt.cursorline = true -- highlight the current cursor line
