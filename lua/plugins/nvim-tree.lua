-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
    print('nvim-tree plugin could not be loaded')
    return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

-- configure nvim-tree
nvimtree.setup({
    -- change folder arrow icons
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
    -- disable window_picker for
    -- explorer to work well with
    -- window splits
    actions = {
        open_file = {
            resize_window = false,
            window_picker = {
                enable = false,
            },
        },
    },
    -- nvim tree "." to enter cd command to change root folder
    update_cwd = true,
    git = {
        ignore = false,
    },
})
