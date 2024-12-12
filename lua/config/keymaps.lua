-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
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

del("t", "<C-/>")
del("t", "<C-_>")

Test = function()
    vim.cmd.stopinsert()
    vim.print(require("config.utils").get_visual_selection())
end

map({ "n", "v" }, "<leader>t", [[<cmd>lua Test()<CR>]])
