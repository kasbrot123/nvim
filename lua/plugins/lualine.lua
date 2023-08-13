-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
    return
end


lualine.setup({
    options = {
        theme = "nightfly",
        -- theme = "auto",
        icons_enabled = false,
        section_separators = { left = '', right = ''},
        component_separators = { left = '|', right = '|'},
    },
})
