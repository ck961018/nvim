local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("n", "<leader>w", "<cmd>w<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader><TAB>", function()
    SaveSession()
    vim.cmd.qa()
end)

-- spilt
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sx", "<cmd>close<CR>")

-- move
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set({ "n", "v" }, "<leader>h", "^")
keymap.set({ "n", "v" }, "<leader>l", "$")
keymap.set({ "n", "v" }, "<A-j>", "10jzz")
keymap.set({ "n", "v" }, "<A-k>", "10kzz")

-- edit
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- view
keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { noremap = true, silent = true })

-- disable
keymap.set("n", "q", "<NOP>", { noremap = true, silent = true })

-- test
keymap.set("n", "<leader>t", ":lua Test()<CR>", { silent = true })

function Test()
    local cur_id = vim.fn.bufnr()
    local bufs_list = require("barbar.state").get_buffer_list()
    local found = false
    for _, buf_id in ipairs(bufs_list) do
        if buf_id == cur_id then
            found = true
            break
        end
    end

    vim.print(#bufs_list, found)
end
