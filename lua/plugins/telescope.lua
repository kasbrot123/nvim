-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
    print('telescope plugin could not be loaded')
    return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    print('telescope.actions plugin could not be loaded')
    return
end

-- configure telescope
telescope.setup({
    -- configure custom mappings
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                ["<C-d>"] = actions.delete_buffer, -- deletes buffer in list
            },
        },
    },
})

-- telescope.load_extension("fzf")
