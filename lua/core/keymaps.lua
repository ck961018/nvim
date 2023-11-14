local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true })

-- spilt
keymap.set("n", "<leader>sv", "<c-w>v")
keymap.set("n", "<leader>sx", "<cmd>close<cr>")

-- move
keymap.set("n", "<a-h>", "<c-w>h")
keymap.set("n", "<a-l>", "<c-w>l")
keymap.set("n", "<a-j>", "<c-w>j")
keymap.set("n", "<a-k>", "<c-w>k")
keymap.set("n", "gt", "<cmd>bn<cr>")
keymap.set("n", "gT", "<cmd>bN<cr>")
keymap.set({ "n", "v" }, "<leader>h", "^")
keymap.set({ "n", "v" }, "<leader>l", "$")

-- edit
keymap.set("v", "J", ":m '>+1<cr>gv=gv")
keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- view
keymap.set('n', '<cr>', ':nohlsearch<cr><cr>', { noremap = true, silent = true })
