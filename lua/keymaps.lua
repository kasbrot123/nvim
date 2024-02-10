vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true }
local silent = { silent = true }


--------------------------------------------------------------------------------
-- my mappings

-- text movements
keymap.set({"n", "v"}, "ß", "$", opts)
keymap.set({"n", "v"}, "H", "^", opts)
keymap.set({"n", "v"}, "L", "$", opts)
keymap.set({"n", "v"}, "J", "<C-d>", opts)
keymap.set({"n", "v"}, "K", "<C-u>", opts)
-- window movements
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set('n', '+', '<cmd>vertical resize +5<cr>', opts)
keymap.set('n', '-', '<cmd>vertical resize -5<cr>', opts)
keymap.set('n', '<leader>+', '<cmd>horizontal resize +2<cr>', opts)
keymap.set('n', '<leader>-', '<cmd>horizontal resize -2<cr>', opts)
keymap.set('n', '<leader>0', '<cmd>wincmd =<cr>', opts)

-- normal mode keymaps
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- toggle file explorer
keymap.set("n", "x", '"_x', opts) -- deletes char without writing to register
keymap.set("n", "a", "A", opts)
keymap.set("n", ">", ">>")
keymap.set("n", "<", "<<")
-- keymap.set('n', '<CR>', ':w<CR>')
-- keymap.set('n', 'q', ':q<CR>')
keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap.set("n", "<leader>v", "<C-v>", opts)
keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>")
keymap.set("n", "<leader>c", ":set nonu | set norelativenumber | set signcolumn=no | set mouse=<cr>")
keymap.set("n", "<leader>cc", ":set nu | set relativenumber | set signcolumn=yes | set mouse=nvi<cr>")
keymap.set("n", "<leader>s", ":set invspell<CR>")
keymap.set("n", "<leader>ss", "z=")
keymap.set('n', '<leader><CR>', ':x<CR>')
keymap.set("v", "<leader>l", ":norm Hi")
keymap.set("n", "<leader>lo", ':lua require("nabla").enable_virt()<CR>', silent)
keymap.set("n", "<leader>lf", ':lua require("nabla").disable_virt()<CR>', silent)

-- command mode
keymap.set("c", "qq", "q!", opts)

-- insert mode
-- keymap.set('i', 'jj', '<ESC>')


--------------------------------------------------------------------------------
-- git diff

-- keymap.set("n", "gh", ":diffget LOCAL")
-- keymap.set("n", "gl", ":diffget BASE")
-- keymap.set("n", "gj", ":diffget REMOTE")
keymap.set("n", "gh", ":diffget //2<CR>")
keymap.set("n", "gl", ":diffget //3<CR>")
keymap.set("n", "<leader>dgo", "zo")


--------------------------------------------------------------------------------
-- terminal & python

run_python = function()
    vim.cmd(':w')
    vim.cmd('2TermExec cmd="\\%cd ' .. vim.fn.expand("%:p:h") .. '"') -- local workspace
    vim.cmd('2TermExec cmd="\\%run ' .. vim.fn.expand("%F") .. '"') --vim.fn.expand("%"))

end


run_visual = function()
    vim.cmd('2ToggleTermSendVisualSelection')
    vim.cmd('wincmd l')
    vim.cmd('norm i')
    vim.cmd('TermExec cmd=""')
end



keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
keymap.set("t", "<C-t>", "<cmd>1ToggleTerm direction=float<cr>", opts)

keymap.set("n", "<C-t>", "<cmd>1ToggleTerm direction=float<cr>", opts)
keymap.set("n", "<leader>op", '<cmd>2TermExec cmd="ipython" direction=vertical<cr>', opts)
keymap.set("n", "<leader>p", '<cmd>2ToggleTerm cmd="ipython" direction=vertical<cr>', opts)
keymap.set("n", "<F5>", "<cmd>lua run_python()<CR>", opts)
keymap.set("v", "<F5>", ":2ToggleTermSendVisualLines<cr>", opts)

keymap.set("n", "<leader>n", "iimport numpy as np\n<ESC>")
keymap.set("n", "<leader>m", "ifrom matplotlib import pyplot as plt\n<ESC>")


--------------------------------------------------------------------------------
-- telescope plugin

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", opts) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts) -- find string in current working directory as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", opts)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts) -- list available help tags
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts) -- find string under cursor in current working directory
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- list available help tags

-- telescope git commands (not on youtube nvim video, opts)
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", opts) -- list all git commits (use <cr> to checkout) ["gc" for git commits]

-- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", opts) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts) -- list current changes per file with diff preview ["gs" for git status]



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

-- restart lsp server (not on youtube nvim video, opts)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
