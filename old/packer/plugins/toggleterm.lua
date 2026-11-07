-- import gitsigns plugin safely
local setup, toggleterm = pcall(require, "toggleterm")
if not setup then
    print('toggleterm plugin could not be loaded')
    return
end

toggleterm.setup()
