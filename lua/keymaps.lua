vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true }


-- delete single character without copying into register
keymap.set("n", "x", '"_x', opts)

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts) -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- list available help tags

-- telescope git commands (not on youtube nvim video, opts)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", opts) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts) -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video, opts)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary


-- my mappings
keymap.set("n", "a", "A", opts)
keymap.set("n", "ß", "$", opts)
keymap.set({"n", "v"}, "H", "^", opts)
keymap.set({"n", "v"}, "L", "$", opts)
keymap.set({"n", "v"}, "J", "<C-d>", opts)
keymap.set({"n", "v"}, "K", "<C-u>", opts)
keymap.set("c", "qq", "q!", opts)
keymap.set("c", "qq", "q!", opts)
keymap.set("n", "<leader>v", "<C-v>", opts)
--keymap.set("n", "<leader>w", "<cmd>wrap")
-- keymap.set("n", "<leader>h", "<C-w>h")
-- keymap.set("n", "<leader>j", "<C-w>j")
-- keymap.set("n", "<leader>k", "<C-w>k")
-- keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<leader>t", "<cmd>terminal<CR>", opts)

michi = function()
    vim.cmd('TermExec cmd="run ' .. vim.fn.expand("%") .. '"') --vim.fn.expand("%"))
end

-- python IDE
keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
keymap.set("n", "<leader>ip", '<cmd>TermExec cmd="ipython"<CR>', opts)
keymap.set("n", "<leader>p", "<cmd>lua michi()<CR>", opts)


-- maps for autocompletion
keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
keymap.set("n", "<C-i>", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

-- nnoremap <leader>w :set wrap!<CR>
-- nnoremap <BS> gt
-- nnoremap <leader>t :terminal<CR>
-- nnoremap <leader>u :UndotreeShow<CR>

-- vnoremap <F5> y :wincmd l<CR>a%cpaste<CR><C-w>:wincmd h<CR> :wincmd l<CR><C-w>""<C-w>:wincmd h<CR>:wincmd l<CR>--<CR>
-- nnoremap <silent> <F5> :w<CR>:wincmd l<CR>a<BS>run <C-w>"#<CR>


-- " maps for python
-- if executable('python3')
--     nnoremap <leader>p :w <bar> :!python3 %<CR>
--     nnoremap <leader>pi :w <bar> :!python3 -i %<CR>
--     nnoremap <silent> <Leader>ip :vertical terminal ipython3<CR>
-- else
--     nnoremap <leader>p :w <bar> :!python %<CR>
--     nnoremap <leader>pi :w <bar> :!python -i %<CR>
--     nnoremap <silent> <Leader>ip :vertical terminal ipython<CR>
-- endif
--


-- nnoremap <silent> <Leader>+ :vertical resize +5<CR>
-- nnoremap <silent> <Leader>- :vertical resize -5<CR>
-- nnoremap <silent> <Leader>= :wincmd =<CR>
-- nnoremap <silent> <Leader>0 :wincmd h <CR> :vertical resize 30 <CR> :wincmd l <CR>


-- use jk to exit insert mode
--keymap.set("i", "jk", "<ESC>")

-- clear search highlights
--keymap.set("n", "<leader>nh", ":nohl<CR>")


-- increment/decrement numbers
--keymap.set("n", "<leader>+", "<C-a>") -- increment
--keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
--keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
--keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
-- keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
-- keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
--keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization



