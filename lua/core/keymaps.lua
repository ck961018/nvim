local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("n", "<leader>w", "<Cmd>w<CR>", { noremap = true, silent = true })

-- spilt
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sx", "<Cmd>close<CR>")

-- move
keymap.set("n", "<A-h>", "<C-w>h")
keymap.set("n", "<A-l>", "<C-w>l")
keymap.set("n", "<A-j>", "<C-w>j")
keymap.set("n", "<A-k>", "<C-w>k")
keymap.set({ "n", "v" }, "<leader>h", "^")
keymap.set({ "n", "v" }, "<leader>l", "$")
keymap.set({ "n", "v" }, "qj", "10<C-e>M")
keymap.set({ "n", "v" }, "qk", "10<C-y>M")


-- edit
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- view
keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { noremap = true, silent = true })

keymap.set("n", "<leader>t", ":lua Test()<CR>")

function Test()
    vim.print(vim.fn.expand(vim.fn.stdpath("state")))
end
