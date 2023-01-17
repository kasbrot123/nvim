-- set colorscheme to nightfly with protected call
-- in case it isn't installed

colorscheme_name = "colorscheme nightfly"
--colorscheme_name = "colorscheme tokyonight"
local status, _ = pcall(vim.cmd, colorscheme_name)
if not status then
    print("Colorscheme not found!") -- print error if colorscheme not installed
    return
end
