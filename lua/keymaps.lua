vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true }
local silent = { silent = true }


--------------------------------------------------------------------------------
-- basic mappings

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
keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap.set("n", "<leader>v", "<C-v>", opts) -- windows terminal
keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>")
keymap.set("n", "<leader>c", ":set nonu | set norelativenumber | set signcolumn=no | set mouse=<cr>")
keymap.set("n", "<leader>cc", ":set nu | set relativenumber | set signcolumn=yes | set mouse=nvi<cr>")
keymap.set("n", "<leader>s", ":set invspell<CR>")
keymap.set("n", "<leader>ss", "1z=")
keymap.set("n", "<leader>sa", "z=")
keymap.set("v", "<leader>l", ":norm Hi")

-- command mode, force quit, save with double hit
keymap.set("c", "qq", "q!", opts)
keymap.set("c", "ww", "w!", opts)
keymap.set("c", "xx", "x!", opts)


--------------------------------------------------------------------------------
-- git diff

keymap.set("n", "<leader>d", ":windo diffthis<CR>")
keymap.set("n", "<leader>dd", ":diffoff!<CR>")

-- keymap.set("n", "gh", ":diffget //2<CR>")
-- keymap.set("n", "gl", ":diffget //3<CR>")
-- keymap.set("n", "<leader>dgo", "zo")
--
-- keymap.set("n", "gh", ":diffget LOCAL")
-- keymap.set("n", "gl", ":diffget BASE")
-- keymap.set("n", "gj", ":diffget REMOTE")


--------------------------------------------------------------------------------
-- terminal & python

run_python = function()
    vim.cmd(':w')
    vim.cmd('2TermExec cmd="\\%reset -f "') -- delete workspace
    vim.cmd('2TermExec cmd="\\%cd ' .. vim.fn.expand("%:p:h") .. '"') -- local workspace
    vim.cmd('2TermExec cmd="\\%run ' .. vim.fn.expand("%:p") .. '"') --vim.fn.expand("%"))

    -- solution found in the issues of toggleterm
    local IPYTHON_TERMINAL_WINDOW = 2
    ipython_terminal = require("toggleterm.terminal").get(IPYTHON_TERMINAL_WINDOW)
    -- ipython_terminal:focus()

    local job_id = ipython_terminal.job_id
    local enter_in_string = string.char(13)
    vim.defer_fn(function()
        vim.fn.chansend(job_id, enter_in_string)
    end, 150)
end


-- run_visual = function()
--     vim.cmd('2ToggleTermSendVisualSelection')
--     vim.cmd('wincmd l')
--     vim.cmd('norm i')
--     vim.cmd('TermExec cmd=""')
-- end

local trim_spaces = false
run_visual2 = function()
-- vim.keymap.set("v", "<leader>b", function()
    -- require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
    -- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
    require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })

    -- solution found in the issues of toggleterm
    local IPYTHON_TERMINAL_WINDOW = 2
    ipython_terminal = require("toggleterm.terminal").get(IPYTHON_TERMINAL_WINDOW)
    -- ipython_terminal:focus()

    local job_id = ipython_terminal.job_id
    local enter_in_string = string.char(13)
    vim.defer_fn(function()
        vim.fn.chansend(job_id, enter_in_string)
    end, 150)
end


keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
keymap.set("t", "<C-t>", "<cmd>1ToggleTerm direction=float<cr>", opts)

keymap.set("n", "<C-t>", "<cmd>1ToggleTerm direction=float<cr>", opts)
keymap.set("n", "<leader>op", '<cmd>2TermExec cmd="ipython" direction=vertical size=60<cr>', opts)
keymap.set("n", "<leader>p", '<cmd>2ToggleTerm cmd="ipython" direction=vertical<cr>', opts)
keymap.set("v", "<leader>x", run_visual2, opts)
keymap.set("n", "<leader>x", run_python, opts)

keymap.set("n", "<leader>n", "iimport numpy as np\n<ESC>")
keymap.set("n", "<leader>m", "ifrom matplotlib import pyplot as plt\n<ESC>")


--------------------------------------------------------------------------------
-- telescope plugin

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", opts) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts) -- find string in current working directory as you type
keymap.set("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", opts)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts) -- list available help tags
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", opts) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts) -- list current changes per file with diff preview ["gs" for git status]
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts) -- find string under cursor in current working directory
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- list available help tags
-- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", opts) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts) -- list git branches (use <cr> to checkout) ["gb" for git branch]



--------------------------------------------------------------------------------
-- maps for autocompletion & ls


keymap.set("n", "gr", vim.lsp.buf.rename) -- smart renaming with lsp
keymap.set("n", "ge", vim.lsp.buf.hover) -- help from lsp, e for "Explain"
keymap.set("n", "gf", "<cmd>Telescope lsp_references<CR>", opts)
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
keymap.set("n", "gD", "<cmd>Telescope diagnostics<CR>", opts)
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor


-- -- every occurence of the word in file
-- keymap.set("n", "<leader>1", "<cmd>Telescope lsp_references<CR>", opts)
--
-- -- every diagnostics, e.g. there is a problem, a module is not imported etc.
-- keymap.set("n", "<leader>2", "<cmd>Telescope diagnostics<CR>", opts)
-- -- 
-- -- print(michi) -> jumps to line where michi = 1
-- keymap.set("n", "<leader>4", "<cmd>Telescope lsp_definitions<CR>", opts)
--
-- -- michi = 1 -> jumps to int definitions since michi is type of int
-- keymap.set("n", "<leader>5", "<cmd>Telescope lsp_type_definitions<CR>", opts)
--
-- -- suggests you code changes like 'import time' if time is not there
-- -- keymap.set("n", "<leader>yd", vim.lsp.buf.code_action) -- no code action for pyright
-- -- keymap.set("n", "<leader>3", "<cmd>Telescope lsp_implementations<CR>", opts)



-- keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
-- keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
-- keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
-- keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
-- keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
-- keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
-- keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
-- keymap.set("n", "<leader>h", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
-- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

-- restart lsp server (not on youtube nvim video, opts)
keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary


--------------------------------------------------------------------------------
-- old keymaps I might use again


-- keymap.set('n', '<CR>', ':w<CR>')
-- keymap.set('n', 'q', ':q<CR>')
-- keymap.set('n', '<leader><CR>', ':x<CR>')
-- keymap.set("n", "<leader>lo", ':lua require("nabla").enable_virt()<CR>', silent)
-- keymap.set("n", "<leader>lf", ':lua require("nabla").disable_virt()<CR>', silent)
-- keymap.set('i', 'jj', '<ESC>') -- normal mode without escape
