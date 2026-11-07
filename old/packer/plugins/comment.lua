-- import comment plugin safely
local setup, comment = pcall(require, "Comment")
if not setup then
    print("comment plugin could not be loaded")
    return
end

-- enable comment
comment.setup()
