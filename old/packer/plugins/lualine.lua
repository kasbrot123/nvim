-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
    print('lualine plugin could not be loaded')
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
    sections = {
        -- Default, when your window is active
        -- lualine_a = {'mode'},
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        -- lualine_c = {'filename'},
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        -- lualine_y = {'progress'},
        -- lualine_z = {'location'}

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
