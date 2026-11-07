-- set colorscheme to nightfly with protected call
-- in case it isn't installed

local colorscheme_name = "colorscheme nightfly"
-- local colorscheme_name = "colorscheme catppuccin"
-- local colorscheme_name = "colorscheme tokyonight"

local status, _ = pcall(vim.cmd, colorscheme_name)
if not status then
    print(colorscheme_name .. ' could not be loaded')
    return
end
