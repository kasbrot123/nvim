-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- mapleader is set in keymaps.lua, which is loaded before this file

-- Setup lazy.nvim
require("lazy").setup({
  spec = {

    ----------------------------------------------------------------------------
    -- general

    -- lua functions that many plugins use
    { "nvim-lua/plenary.nvim", lazy = true },

    -- shows pending keymaps in a popup (press <leader> and wait)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            spec = {
                { "<leader>f", group = "find" },
                { "<leader>c", group = "clean view / code" },
                { "<leader>d", group = "diff / debug" },
                { "<leader>s", group = "spell" },
                { "<leader>g", group = "git" },
                { "<leader>o", group = "open" },
                { "g", group = "goto / lsp" },
            },
        },
    },

    -- undotree for better file history, deactivate swapfiles
    { "mbbill/undotree" },

    -- terminal
    { "akinsho/toggleterm.nvim", version = "*", config = true },

    -- tables in markdown
    { "dhruvasagar/vim-table-mode" },

    -- auto closing brackets (blink.cmp adds brackets after functions itself)
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

    -- file templates, used by <leader>h
    {
        "nvimdev/template.nvim",
        cmd = { "Template", "TemProject" },
        config = function()
            require("template").setup({
                temp_dir = vim.fn.stdpath("config") .. "/templates",
                author = "Michael T.",
                email = "michael@email",
            })
        end,
    },

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            -- <leader>a to apend files
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add(); print("Hook added") end, { desc = "Harpoon add file" })
            -- menue next to my "file tree button" <leader>e
            vim.keymap.set("n", "<leader>r", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
        end,
    },


    ----------------------------------------------------------------------------
    -- git

    -- Git integration
    { "tpope/vim-fugitive" },

    -- git signs in the sign column
    { "lewis6991/gitsigns.nvim", opts = { sign_priority = 100 } },

    -- Diffview for git
    { "sindrets/diffview.nvim" },


    ----------------------------------------------------------------------------
    -- look

    -- Colorschemes: only bamboo is loaded at startup, the others are loaded
    -- when you run :colorscheme <name> (lazy.nvim does that automatically)
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000, -- load before all the other start plugins
        config = function()
            vim.cmd([[colorscheme bamboo]])
        end,
    },
    { "bluz71/vim-nightfly-colors", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = true },
    { "catppuccin/nvim", lazy = true },
    { "rose-pine/neovim", lazy = true },
    { "Mofiqul/vscode.nvim", lazy = true },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                icons_enabled = false,
                section_separators = { left = "", right = "" },
                component_separators = { left = "|", right = "|" },
            },
            sections = {
                -- Default, when your window is active
                -- lualine_a = {'mode'},
                -- lualine_b = {'branch', 'diff', 'diagnostics'},
                -- lualine_c = {{'filename', path = 0}}, -- 0 = just filename, 1 = relative path, 2 = absolute path
                -- lualine_x = {'encoding', 'fileformat', 'filetype'},
                -- lualine_y = {'progress'},
                -- lualine_z = {'location'}
                lualine_b = { "branch", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filesize" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filesize" },
            },
        },
    },


    ----------------------------------------------------------------------------
    -- navigation

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local function my_on_attach(bufnr)
                local api = require("nvim-tree.api")
                api.config.mappings.default_on_attach(bufnr)

                -- <C-t> would overwrite the toggleterm keymap
                vim.keymap.del("n", "<C-t>", { buffer = bufnr })
            end

            require("nvim-tree").setup({
                -- change folder arrow icons, if nerd font is not present
                renderer = {
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = ">", -- arrow when folder is closed
                                arrow_open = "v", -- arrow when folder is open
                            },
                        },
                    },
                },
                actions = {
                    open_file = {
                        resize_window = false,
                        -- ask which window to open the file in when there are splits
                        window_picker = { enable = true },
                    },
                },
                -- nvim tree "." to enter cd command to change root folder
                sync_root_with_cwd = true,
                git = { ignore = false },
                on_attach = my_on_attach,
            })
        end,
    },

    -- fuzzy finder (replaces telescope), only the picker module of snacks is used
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = {
                layout = { preset = "vertical" },
                win = {
                    input = {
                        keys = {
                            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
                            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
                            ["<C-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
                            ["<C-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
                        },
                    },
                },
            },
        },
        keys = {
            { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find files" },
            { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep in project" },
            { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor", mode = { "n", "x" } },
            { "<leader>fs", function() Snacks.picker.spelling() end, desc = "Spell suggestions" },
            { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>fB", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fb", function() Snacks.picker.pickers() end, desc = "All pickers" },
            { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>fh", function() Snacks.picker.help() end, desc = "Help pages" },
            { "<leader>fo", function() Snacks.picker.recent() end, desc = "Recent files" },
            { "<leader>fr", function() Snacks.picker.resume() end, desc = "Resume last picker" },
            { "<leader>fC", function() Snacks.picker.git_log() end, desc = "Git commits" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true }) end, desc = "Neovim config files" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
            { "gf", function() Snacks.picker.lsp_references() end, desc = "LSP references" },
            { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP type definitions" },
        },
    },


    ----------------------------------------------------------------------------
    -- treesitter (main branch, the new rewrite)
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- markdown_inline is needed for bold, links, ... inside markdown
            local languages = { "python", "lua", "vim", "vimdoc", "rust", "markdown", "markdown_inline" }
            vim.env.CC = "gcc"

            local ts = require("nvim-treesitter")
            ts.setup({
                -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
                install_dir = vim.fn.stdpath("data") .. "/site",
            })
            ts.install(languages)

            -- the main branch does not enable highlighting by itself
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python", "lua", "vim", "help", "rust", "markdown" },
                callback = function() vim.treesitter.start() end,
            })
        end,
    },


    ----------------------------------------------------------------------------
    -- LSP
    -- uses the native vim.lsp.config / vim.lsp.enable API (Neovim 0.11+).
    -- nvim-lspconfig only ships the server configs, mason-lspconfig installs
    -- the servers and enables them. blink.cmp adds its capabilities itself.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            -- installs the formatters for conform.nvim via mason
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()
            require("mason-tool-installer").setup({
                -- ruff is missing on purpose: the mason install fails on windows,
                -- install it with "pip install ruff" instead (conform finds it in PATH)
                ensure_installed = { "stylua", "clang-format" },
            })

            -- server specific settings go here, e.g.
            -- vim.lsp.config("pyright", { settings = { ... } })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "lua_ls",
                    "lemminx",
                    "clangd",
                },
                automatic_enable = true,
            })

            -- LSP diagnostics
            vim.diagnostic.config({
                severity_sort = true,
                -- virtual text on every line; use { current_line = true } to only
                -- show it on the cursor line
                virtual_text = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "if_many",
                    header = "",
                    prefix = "",
                },
            })
        end,
    },

    -- autocompletion (replaces nvim-cmp + its sources + LuaSnip + lspkind)
    {
        "saghen/blink.cmp",
        version = "1.*", -- downloads a prebuilt fuzzy matcher binary
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets", -- vs-code like snippets
            -- blink.compat lets blink use nvim-cmp sources, here only for cmp-calc
            { "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },
            "hrsh7th/cmp-calc", -- calculate math expressions
        },
        opts = {
            keymap = {
                preset = "none",
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<C-k>"] = { "scroll_documentation_up", "fallback" },
                ["<C-j>"] = { "scroll_documentation_down", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
            },
            completion = {
                -- nothing preselected, <CR> only accepts after choosing with <Tab>
                list = { selection = { preselect = false, auto_insert = true } },
                documentation = { auto_show = true },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "calc" },
                providers = {
                    calc = { name = "calc", module = "blink.compat.source" },
                },
            },
        },
    },

    -- formatting
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        keys = {
            { "<leader>cf", function() require("conform").format({ async = true }) end, mode = { "n", "x" }, desc = "Format file / selection" },
        },
        config = function()
            -- the formatters are installed by mason-tool-installer (see LSP block)
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                },
                -- use the lsp formatter if there is no formatter configured above
                default_format_opts = { lsp_format = "fallback" },
                -- format on save is off, uncomment to enable it
                -- format_on_save = { timeout_ms = 500 },
            })
        end,
    },


    ----------------------------------------------------------------------------
    -- Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mason-org/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            -- Hier kannst du sprachspezifische Erweiterungen hinzufügen
            "mfussenegger/nvim-dap-python", -- Speziell für Python
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("mason-nvim-dap").setup({
                -- Hier die Debugger eintragen, die Mason installieren soll
                ensure_installed = { "python", "cpptools" },
                automatic_installation = true,
            })

            -- UI Setup
            dapui.setup()

            -- Automatisches Öffnen/Schließen der UI
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- Python spezifisch (benötigt nvim-dap-python)
            require("dap-python").setup("python") -- nutzt den python in deinem PATH

            -- Keymaps für das Debugging
            vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F1>", function() dap.step_out() end, { desc = "Debug: Step Out" }) -- breakpoint to breakpoint
            vim.keymap.set("n", "<F2>", function() dap.step_over() end, { desc = "Debug: Step Over" }) -- every line
            vim.keymap.set("n", "<F3>", function() dap.step_into() end, { desc = "Debug: Step Into" }) -- every line including stepping into function
            vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Breakpoint with Condition" })

            -- UI manuell togglen
            vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Debug: Toggle UI" })
        end,
    },


    -- -------------------------------------------------------------------------
    -- old plugins

    -- commenting with gc (built into Neovim since 0.10)
    -- {"numToStr/Comment.nvim"},

    -- for undistracted writing
    -- {"junegunn/goyo.vim"},

    -- measure the startup time
    -- {"dstein64/vim-startuptime"},

    -- formulas shown prettier
    -- {'jbyuki/nabla.nvim'},

    -- language translation
    -- {"potamides/pantran.nvim"},

    -- {"windwp/nvim-ts-autotag"}, -- autoclose tags, html

    -- {
    --     "NeogitOrg/neogit",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",         -- required
    --         "sindrets/diffview.nvim",        -- optional - Diff integration
    --     },
    --     config = true
    -- },
  },

  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- check for plugin updates once a week (only on sundays)
  checker = { enabled = os.date("%a") == "Sun", notify = false, frequency = 86400 * 7 },
  rocks = { enabled = false },
})
