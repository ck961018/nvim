-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
local del = vim.keymap.del

map("n", "<A-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<A-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<A-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<A-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

del("n", "<C-h>")
del("n", "<C-j>")
del("n", "<C-k>")
del("n", "<C-l>")

del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")

del("n", "<S-h>")
del("n", "<S-l>")
del("n", "<leader>`")

del("n", "<leader>K")

del("n", "<leader>l")
del("n", "<leader>L")

del("t", "<esc><esc>")
del("t", "<C-h>")
del("t", "<C-j>")
del("t", "<C-k>")
del("t", "<C-l>")
del("t", "<C-/>")
del("t", "<C-_>")
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>-")
del("n", "<leader>|")

Test = function()
    local list = require("persistence").list()
    vim.print(list)
end

map("n", "<leader>t", [[<cmd>lua Test()<CR>]])
