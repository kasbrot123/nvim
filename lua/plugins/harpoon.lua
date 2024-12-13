-- import gitsigns plugin safely
local setup, harpoon = pcall(require, "harpoon")
if not setup then
    print('harpoon plugin could not be loaded')
    return
end

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- <leader>a to apend files
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

-- menue next to my "file tree button" <leader>e
vim.keymap.set("n", "<leader>r", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- rest I dont need

vim.keymap.set("n", "<space>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<space>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<space>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<space>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
