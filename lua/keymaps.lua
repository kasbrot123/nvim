vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = false }
local noremap = { noremap = true }


--------------------------------------------------------------------------------
-- basic mappings

-- if you press leader it will move the cursor
keymap.set("n", "<Space>", "<Nop>", opts)

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
keymap.set("n", "<leader>d", ":windo diffthis<CR>", noremap)
keymap.set("n", "<leader>dd", ":diffoff!<CR>", noremap)

-- visual mode keymaps
keymap.set("v", "<leader>l", ":norm Hi", opts)

-- command mode, force quit, save with double hit
keymap.set("c", "qq", "q!", opts)
keymap.set("c", "ww", "w!", opts)
keymap.set("c", "xx", "x!", opts)

-- Autocompletion and LSP
keymap.set("n", "gr", vim.lsp.buf.rename, opts)
keymap.set("n", "gh", vim.lsp.buf.hover, opts)
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
-- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
keymap.set("n", "<leader>vD", vim.diagnostic.open_float, opts)
keymap.set("n", "gf", "<cmd>Telescope lsp_references<CR>", opts)
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


--------------------------------------------------------------------------------
-- helper functions

local header_text = function()
    local file_type = vim.o.filetype
    vim.cmd(":Template " .. file_type)
    vim.cmd(':lua print("Template for '..file_type..'")')
end

local run_python = function()
    vim.cmd(':w')
    -- vim.cmd.write() -- another way

    local cmd_reset = "%reset -f"
    local folder_path = vim.fn.expand("%:p:h"):gsub("\\", "\\\\")
    local cmd_cd = "%cd -q \"" .. folder_path .. "\""
    local script_path = vim.fn.expand("%:p"):gsub("\\", "\\\\")
    local cmd_run = "%run \"" .. script_path .. "\""
    local full_command = cmd_reset .. "\n" .. cmd_cd .. "\n" .. cmd_run

    local toggleterm = require("toggleterm")
    toggleterm.exec(full_command, 2)

    -- solution found in the issues of toggleterm
    local IPYTHON_TERMINAL_WINDOW = 2
    local ipython_terminal = require("toggleterm.terminal").get(IPYTHON_TERMINAL_WINDOW)
    -- ipython_terminal:focus()

    local job_id = ipython_terminal.job_id
    local enter_in_string = string.char(13)
    vim.defer_fn(function()
        vim.fn.chansend(job_id, enter_in_string)
    end, 150)
end

-- this function can be 
local execute_program = function()
    local toggleterm = require("toggleterm")
    local file_ext = vim.fn.expand("%:e")

    if file_ext == 'py' then
        run_python()
        -- terminal way
        -- vim.cmd(":1ToggleTerm direction=float")
        -- toggleterm.exec("python "..vim.fn.expand("%:p:h"), 1)
    elseif file_ext == 'cpp' then
        vim.cmd(":1ToggleTerm direction=float")
        toggleterm.exec("g++ *.cpp && a.exe", 1)
        -- difference for linux and windows
    else
        vim.cmd(':lua print("Program not defined for: .'..file_ext..'")')
    end

end

local trim_spaces = false
local run_python_visual = function()
    require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })

    -- solution found in the issues of toggleterm
    local IPYTHON_TERMINAL_WINDOW = 2
    local Ipython_terminal = require("toggleterm.terminal").get(IPYTHON_TERMINAL_WINDOW)
    -- ipython_terminal:focus()

    local job_id = Ipython_terminal.job_id
    local enter_in_string = string.char(13)
    vim.defer_fn(function()
        vim.fn.chansend(job_id, enter_in_string)
    end, 150)
end


--------------------------------------------------------------------------------
-- terminal things

keymap.set("n", "<leader>h", header_text, opts)
keymap.set("n", "<leader>x", execute_program, opts)
keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
keymap.set({"n", "t"}, "<C-t>", "<cmd>1ToggleTerm direction=float<cr>", opts)
keymap.set("n", "<leader>op", '<cmd>2TermExec cmd="ipython" direction=vertical size=60<cr>', opts)
keymap.set("n", "<leader>p", '<cmd>2ToggleTerm cmd="ipython" direction=vertical<cr>', opts)
keymap.set("n", "<leader>x", execute_program, opts)
keymap.set("v", "<leader>x", run_python_visual, opts)


--------------------------------------------------------------------------------
-- old keymaps I might use again


-- keymap.set('n', '<CR>', ':w<CR>')
-- keymap.set('n', 'q', ':q<CR>')
-- keymap.set('n', '<leader><CR>', ':x<CR>')
-- keymap.set("n", "<leader>lo", ':lua require("nabla").enable_virt()<CR>', silent)
-- keymap.set("n", "<leader>lf", ':lua require("nabla").disable_virt()<CR>', silent)
-- keymap.set('i', 'jj', '<ESC>') -- normal mode without escape

