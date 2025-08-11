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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {

      -- lua functions that many plugins use
      {"nvim-lua/plenary.nvim", lazy = true},

      -- Colorschemes
      {
          'bluz71/vim-nightfly-colors',
          dependencies = {
              'rebelot/kanagawa.nvim',
              'catppuccin/nvim'
          },
          priority = 1000, -- make sure to load this before all the other start plugins
          config = function()
              -- load the colorscheme here
              vim.cmd([[colorscheme nightfly]])
              -- vim.cmd([[colorscheme kanagawa]])
              -- vim.cmd([[colorscheme catppuccin]])
          end,
      },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            -- vs-code like icons
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            -- i want to delete the default <C-t> in nvim-tree because it 
            -- overwrites the toggle term keymap
            local function my_on_attach(bufnr)
              local api = require("nvim-tree.api")
              local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
              end
              api.config.mappings.default_on_attach(bufnr)

              -- custom mappings
              vim.keymap.del("n", "r", { buffer = bufnr })
              vim.keymap.set('n', 'r', api.fs.rename, { buffer = bufnr, silent = true })
              vim.keymap.del("n", "a", { buffer = bufnr })
              vim.keymap.set('n', 'a', api.fs.create, { buffer = bufnr, silent = true })
              vim.keymap.del("n", "d", { buffer = bufnr })
              vim.keymap.set('n', 'd', api.fs.remove, { buffer = bufnr, silent = true })

              -- remove a default
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
                -- disable window_picker for explorer to work well with window splits
                actions = {
                    open_file = {
                        resize_window = false,
                        window_picker = {
                            enable = true,
                        },
                    },
                },
                -- nvim tree "." to enter cd command to change root folder
                update_cwd = true,
                git = {
                    ignore = false,
                },
                on_attach = my_on_attach,
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        -- dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        dependencies = { "echasnovski/mini.icons" },
        enabled = false,
        opts = {},
        keys={
            {
                "<leader>ff",
                function() require('fzf-lua').files() end,
                desc="Find Files in project directory"
            },
            {
                "<leader>fg",
                function() require('fzf-lua').live_grep() end,
                desc="Find by grepping in project directory"
            },
            {
                "<leader>fc",
                function() require('fzf-lua').files({cwd=vim.fn.stdpath("config")}) end,
                desc="Find in neovim configuration"
            },
            {
                "<leader>fh",
                function()
                    require("fzf-lua").helptags()
                end,
                desc = "[F]ind [H]elp",
            },
            {
                "<leader>fk",
                function()
                    require("fzf-lua").keymaps()
                end,
                desc = "[F]ind [K]eymaps",
            },
            {
                "<leader>fb",
                function()
                    require("fzf-lua").builtin()
                end,
                desc = "[F]ind [B]uiltin FZF",
            },
            {
                "<leader>fw",
                function()
                    require("fzf-lua").grep_cword()
                end,
                desc = "[F]ind current [W]ord",
            },
            {
                "<leader>fW",
                function()
                    require("fzf-lua").grep_cWORD()
                end,
                desc = "[F]ind current [W]ORD",
            },
            {
                "<leader>fd",
                function()
                    require("fzf-lua").diagnostics_document()
                end,
                desc = "[F]ind [D]iagnostics",
            },
            {
                "<leader>fw",
                function()
                    require("fzf-lua").diagnostics_workspace()
                end,
                desc = "[F]ind [D]iagnostics",
            },
            {
                "<leader>fr",
                function()
                    require("fzf-lua").resume()
                end,
                desc = "[F]ind [R]esume",
            },
            {
                "<leader>fo",
                function()
                    require("fzf-lua").oldfiles()
                end,
                desc = "[F]ind [O]ld Files",
            },
            {
                "<leader><leader>",
                function()
                    require("fzf-lua").buffers()
                end,
                desc = "[,] Find existing buffers",
            },
            {
                "<leader>/",
                function()
                    require("fzf-lua").lgrep_curbuf()
                end,
                desc = "[/] Live grep the current buffer",
            },
        }
    },
    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    -- theme = "nightfly",
                    theme = "auto",
                    icons_enabled = false,
                    section_separators = { left = '', right = ''},
                    component_separators = { left = '|', right = '|'},
                },
                sections = {
                    -- Default, when your window is active
                    -- lualine_a = {'mode'},
                    -- lualine_b = {'branch', 'diff', 'diagnostics'},
                    -- lualine_c = {{'filename', path = 0}}, -- 0 = just filename, 1 = relative path, 2 = absolute path

                    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
                    -- lualine_y = {'progress'},
                    -- lualine_z = {'location'}

                    lualine_c = {{'filename', path = 1}},
                    lualine_b = {'branch', 'diagnostics'},
                    lualine_x = {'encoding', 'fileformat', 'filesize'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    -- Default, when you have a split window which is inactive
                    -- lualine_a = {},
                    -- lualine_b = {},
                    -- lualine_c = {'filename'},
                    -- lualine_x = {'location'},
                    -- lualine_y = {},
                    -- lualine_z = {}

                    lualine_x = {'encoding', 'fileformat', 'filesize'},
                }
            })
        end,
    },

    -- fuzzy finding w/ telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        -- configure custom mappings
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<S-Tab>"] = actions.move_selection_next, -- move to next result
                            ["<Tab>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.preview_scrolling_down, -- move to next result
                            ["<C-k>"] = actions.preview_scrolling_up, -- move to prev result
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                            ["<C-d>"] = actions.delete_buffer, -- deletes buffer in list
                        },
                    },
                    layout_strategy = 'vertical',
                },
            })
        end,
    },

    -- Git integration
    {"tpope/vim-fugitive"},

    -- git integration
    {"lewis6991/gitsigns.nvim", -- show line modifications on left hand side
        config = function()
            require("gitsigns").setup {
                sign_priority=100
            }
        end,
    },

    -- undotree for better file history, deactivate swapfiles
    {"mbbill/undotree"},

    -- Diffview for git
    {"sindrets/diffview.nvim"},

    -- terminal
    {'akinsho/toggleterm.nvim', version = "*", config = true},

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            -- REQUIRED
            harpoon:setup()
            -- REQUIRED

            -- <leader>a to apend files
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add(); print('Hook added') end)
            -- menue next to my "file tree button" <leader>e
            vim.keymap.set("n", "<leader>r", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<space>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<space>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<space>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<space>4", function() harpoon:list():select(4) end)
        end,
    },

    -- treesitter configuration
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "python"},
                -- sync_install = false,
                highlight = { enable = true },
                indent = { enable = false },
                autotag = { enable = true }, -- enable autotagging (w/ nvim-ts-autotag plugin)
                auto_install = false,

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })
        end,
    },

    {
        "dhruvasagar/vim-table-mode"
    },

    -- auto closing
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        dependencies = {
            -- after nvim-treesitter
            "windwp/nvim-ts-autotag"
        },
        config = function()
            local autopairs = require("nvim-autopairs")
            autopairs.setup({
                check_ts = true, -- enable treesitter
                ts_config = {
                    lua = { "string" }, -- don't add pairs in lua string treesitter nodes
                    javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
                    java = false, -- don't check treesitter on java
                },
            })
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            -- make autopairs and completion work together
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        'glepnir/template.nvim',
        cmd = {'Template','TemProject'},
        config = function()
            require('template').setup({
                -- config in there
                temp_dir = vim.fn.stdpath("config")..'/templates',
                author = 'Michael T.',
                email = 'michael@email',
            })
        end
    },

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },

    -- new LSP config
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            'hrsh7th/nvim-cmp',

            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp", -- for autocompletion
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            'hrsh7th/cmp-calc', -- calculate math expressions

            "onsails/lspkind.nvim",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function ()
            local mason = require("mason")
            local masonlsp = require("mason-lspconfig")
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            local lspconfig = require("lspconfig")
            local lspconfig_defaults = lspconfig.util.default_config
            require("luasnip/loaders/from_vscode").lazy_load()

            -- jump to next item in snippet
            -- it overwrites tab, so not usable
            -- vim.keymap.set({"i", "s"}, "<Tab>", function() luasnip.jump( 1) end, {silent = true})

            mason.setup({
                automatic_installation = false, -- not the same as ensure_installed
            })

            -- this part is necessary to tell every lsp server what the client
            -- can do. you can specify by server or just overwrite the default capabilities
            -- 'lspconfig_defaults' are the default capabilities by the nvim lsp client
            -- and the other capabilities come from the cmp plugin
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            cmp.setup({
                -- snippet engine for lsp
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- configure lspkind for vs-code like icons in auto completion
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- lsp
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                    { name = "calc" }, -- math expressions
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion window
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                }),
            })

            -- lsp servers
            masonlsp.setup({
                ensure_installed = {
                    "pyright",
                    "lua_ls",
                    "lemminx",
                    "clangd",
                },
                handlers = {
                    -- The first entry (without a key) will be the default handler
                    -- and will be called for each installed server that doesn't have
                    -- a dedicated handler.
                    -- Next, you can provide a dedicated handler for specific servers.
                    -- For example, a handler override for the `rust_analyzer`:
                    -- ["rust_analyzer"] = function ()
                        --     require("rust-tools").setup {}
                        -- end
                    function (server_name) -- default handler (optional)
                        -- require("lspconfig")[server_name].setup {} -- old way
                        -- {} is the settings list for each server
                        -- e.g. you can set the capabilities there by
                        -- {capabilities = ...}
                        lspconfig[server_name].setup({})
                    end,

                    -- because vim variable in lua gives warnings
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    }
                                }
                            }
                        }
                    end,

                },

            })

            -- LSP diagnostics
            vim.diagnostic.config({
                severity_sort = true,
                virtual_text = true,
                current_line_virtual_text = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    -- source = "always",
                    source = "if_many",
                    header = "",
                    prefix = "",
                },
            })

        end,
    },


    -- -------------------------------------------------------------------------

    -- old plugins

    -- commenting with gc
    -- {"numToStr/Comment.nvim"},
    -- {"tpope/vim-commentary"},

    -- for undistracted writing
    -- {"junegunn/goyo.vim"},

    -- measure the startup time
    -- {"dstein64/vim-startuptime"},

    -- formulas shown prettier
    -- {'jbyuki/nabla.nvim'},

    -- language translation
    -- {"potamides/pantran.nvim"},

    -- Github Copilot (Test)
    -- use("github/copilot.vim")

    -- {"windwp/nvim-autopairs"}, -- autoclose parens, brackets, quotes, etc...
    -- {"windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose tags, html

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false, frequency = 86400 }, -- every day
})
