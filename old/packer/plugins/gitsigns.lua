-- import gitsigns plugin safely
local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
    print('gitsigns plugin could not be loaded')
    return
end

-- configure/enable gitsigns
gitsigns.setup()
