-- import lualine plugin safely
local status, glow = pcall(require, "glow")
if not status then
    print('glow plugin could not be loaded')
    return
end


glow.setup({
})


