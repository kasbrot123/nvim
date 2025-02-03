vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true }
local silent = { silent = true }


--------------------------------------------------------------------------------
-- basic mappings

-- if you press leader it will move the cursor
vim.keymap.set("n", "<Space>", "<Nop>", silent)

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
keymap.set("n", ">", ">>", opts)
keymap.set("n", "<", "<<", opts)
keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap.set("n", "<leader>v", "<C-v>", opts) -- windows terminal
keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", opts)
keymap.set("n", "<leader>c", ":set nonu | set norelativenumber | set signcolumn=no | set mouse=<cr>", opts)
keymap.set("n", "<leader>cc", ":set nu | set relativenumber | set signcolumn=yes | set mouse=nvi<cr>", opts)
keymap.set("n", "<leader>s", ":set invspell<CR>", opts)
keymap.set("n", "<leader>ss", "1z=", opts)
keymap.set("n", "<leader>sa", "z=", opts)
keymap.set("n", "<leader>d", ":windo diffthis<CR>", opts)
keymap.set("n", "<leader>dd", ":diffoff!<CR>", opts)

-- visual mode keymaps
keymap.set("v", "<leader>l", ":norm Hi", opts)

-- command mode, force quit, save with double hit
keymap.set("c", "qq", "q!", opts)
keymap.set("c", "ww", "w!", opts)
keymap.set("c", "xx", "x!", opts)

-- maps for autocompletion & ls
keymap.set("n", "gr", vim.lsp.buf.rename, opts) -- smart renaming with lsp
keymap.set("n", "gh", vim.lsp.buf.hover, opts) -- help from lsp, e for "Explain"
keymap.set("n", "gf", "<cmd>Telescope lsp_references<CR>", opts)
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
keymap.set("n", "gD", "<cmd>Telescope diagnostics<CR>", opts)
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

-- telescope plugin
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", opts)
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap.set("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", opts)
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts)
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", opts)
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts)
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
-- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", opts)
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)


--------------------------------------------------------------------------------
-- terminal & python

local run_python = function()
    vim.cmd(':w')
    -- vim.cmd.write() -- another way

    -- old solution
    -- vim.cmd('2TermExec cmd="\\%reset -f "') -- delete workspace
    -- vim.cmd('2TermExec cmd="\\%cd ' .. vim.fn.expand("%:p:h") .. '"') -- local workspace
    -- vim.cmd('2TermExec cmd="\\%cd %:p:h "') -- local workspace
    -- vim.cmd('2TermExec cmd="\\%run ' .. vim.fn.expand("%:p") .. '"') --vim.fn.expand("%"))

    local cmd_reset = "%reset -f"
    local folder_path = vim.fn.expand("%:p:h"):gsub("\\", "\\\\")
    local cmd_cd = "%cd -q \"" .. folder_path .. "\""
    local script_path = vim.fn.expand("%:p"):gsub("\\", "\\\\")
    local cmd_run = "%run \"" .. script_path .. "\""
    local full_command = cmd_reset .. "\n" .. cmd_cd .. "\n" .. cmd_run

    local toggleterm = require("toggleterm")

    -- every line it self
    -- toggleterm.exec(cmd_reset, 2)
    -- toggleterm.exec(cmd_cd, 2)
    -- toggleterm.exec(cmd_run, 2)

    -- or compact without lines in interpreter
    toggleterm.exec(full_command, 2)


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


local trim_spaces = false
local run_python_visual = function()
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
keymap.set("n", "<leader>x", run_python, opts)
keymap.set("v", "<leader>x", run_python_visual, opts)

keymap.set("n", "<leader>n", "iimport numpy as np\n<ESC>", opts)
keymap.set("n", "<leader>m", "ifrom matplotlib import pyplot as plt\n<ESC>", opts)

--------------------------------------------------------------------------------
-- old keymaps I might use again


-- keymap.set('n', '<CR>', ':w<CR>')
-- keymap.set('n', 'q', ':q<CR>')
-- keymap.set('n', '<leader><CR>', ':x<CR>')
-- keymap.set("n", "<leader>lo", ':lua require("nabla").enable_virt()<CR>', silent)
-- keymap.set("n", "<leader>lf", ':lua require("nabla").disable_virt()<CR>', silent)
-- keymap.set('i', 'jj', '<ESC>') -- normal mode without escape

