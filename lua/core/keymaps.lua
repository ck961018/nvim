local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("i", "<leader>w", "<esc><cmd>w<cr>", { noremap = true, silent = true })
keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true })

-- quit
keymap.set("i", "<leader>wq", "<esc><cmd>w<cr><cmd>lua QuitBuffer()<cr>")
keymap.set("n", "<leader>wq", "<cmd>w<cr><cmd>lua QuitBuffer()<cr>")
keymap.set("i", "<leader>q", "<esc><cmd>lua QuitBuffer()<cr>")
keymap.set("n", "<leader>q", "<cmd>lua QuitBuffer()<cr>")

-- spilt
keymap.set("n", "<leader>sv", "<c-w>v")
keymap.set("n", "<leader>sx", "<cmd>close<cr>")

-- move
keymap.set("n", "<c-h>", "<c-w>h")
keymap.set("n", "<c-l>", "<c-w>l")
keymap.set("n", "<c-j>", "<c-w>j")
keymap.set("n", "<c-k>", "<c-w>k")
keymap.set("n", "gt", "<cmd>bn<cr>")
keymap.set("n", "gT", "<cmd>bN<cr>")


-- edit
keymap.set("v", "J", ":m '>+1<cr>gv=gv")
keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- view
keymap.set('n', '<cr>', ':nohlsearch<cr><cr>', { noremap = true, silent = true })


-- function
function QuitBuffer()
    local buf_listed = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)')

    if #buf_listed > 1 then
        vim.cmd('bdelete')
    else
        vim.cmd('quit')
    end
end
