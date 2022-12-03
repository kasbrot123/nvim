vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness



-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary


-- my mappings
keymap.set("n", "a", "A")
keymap.set("n", "ß", "$")
keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
keymap.set("n", "J", "<C-d>")
keymap.set("n", "K", "<C-u>")
keymap.set("c", "qq", "q!")
keymap.set("c", "qq", "q!")
keymap.set("n", "<leader>v", "<C-v>")
--keymap.set("n", "<leader>w", "<cmd>wrap")
-- keymap.set("n", "<leader>h", "<C-w>h")
-- keymap.set("n", "<leader>j", "<C-w>j")
-- keymap.set("n", "<leader>k", "<C-w>k")
-- keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<leader>t", "<cmd>terminal<CR>")

michi = function()
    vim.cmd('TermExec cmd="run ' .. vim.fn.expand("%") .. '"') --vim.fn.expand("%"))
end

-- python IDE
keymap.set("t", "<ESC>", "<C-\\><C-n>")
keymap.set("n", "<leader>ip", '<cmd>TermExec cmd="ipython"<CR>')
keymap.set("n", "<leader>p", "<cmd>lua michi()<CR>")



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




