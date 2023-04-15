vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true }


--------------------------------------------------------------------------------
-- my mappings


-- delete single character without copying into register
keymap.set("n", "x", '"_x', opts)
keymap.set("n", "a", "A", opts)
keymap.set("n", "ß", "$", opts)
keymap.set({"n", "v"}, "H", "^", opts)
keymap.set({"n", "v"}, "L", "$", opts)
keymap.set({"n", "v"}, "J", "<C-d>", opts)
keymap.set({"n", "v"}, "K", "<C-u>", opts)
keymap.set("c", "qq", "q!", opts)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", opts)
-- keymap.set('n', '<leader>+', '<cmd>vertical resize +5<cr>', opts)
-- keymap.set('n', '<leader>-', '<cmd>vertical resize -5<cr>', opts)
keymap.set('n', '+', '<cmd>vertical resize +5<cr>', opts)
keymap.set('n', '-', '<cmd>vertical resize -5<cr>', opts)
keymap.set('n', '<leader>0', '<cmd>wincmd =<cr>', opts)
keymap.set("n", "<leader>v", "<C-v>", opts)
keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>")

-- keymap.set("n", "<tab>", ">>", opts)
-- keymap.set("n", "<s-Tab>", "<<", opts)
-- keymap.set("v", "<tab>", ">", opts)
-- keymap.set("v", "<s-Tab>", "<", opts)


run_python = function()
    vim.cmd(':w')
    vim.cmd('TermExec cmd="\\%run ' .. vim.fn.expand("%") .. '"') --vim.fn.expand("%"))
end

keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=vertical<cr>", opts)
keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)

-- python shortcuts
keymap.set("n", "<leader>op", '<cmd>TermExec cmd="ipython" size=40 direction=vertical<CR>', opts)
keymap.set("n", "<leader>p", "<cmd>lua run_python()<CR>", opts)
keymap.set("v", "<leader>p", ":ToggleTermSendVisualSelection<cr>", opts)
keymap.set("n", "<leader>n", "iimport numpy as np\n<ESC>")
keymap.set("n", "<leader>m", "ifrom matplotlib import pyplot as plt\n<ESC>")


--------------------------------------------------------------------------------
-- plugins


-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", opts) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts) -- find string in current working directory as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", opts)
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- list open buffers in current neovim instance
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- list available help tags
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts) -- list available help tags

-- telescope git commands (not on youtube nvim video, opts)
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", opts) -- list all git commits (use <cr> to checkout) ["gc" for git commits]

-- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", opts) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts) -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video, opts)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary


--------------------------------------------------------------------------------
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
keymap.set("n", "<leader>h", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

