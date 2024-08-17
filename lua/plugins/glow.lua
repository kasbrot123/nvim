-- import lualine plugin safely
local status, glow = pcall(require, "glow")
if not status then
    return
end


glow.setup({
})


