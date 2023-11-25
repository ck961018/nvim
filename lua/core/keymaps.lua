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

keymap.set("v", "<leader>y", "\"+y", { noremap = true })
keymap.set("n", "<leader>p", "\"+p", { noremap = true })
keymap.set("v", "p", "\"0p", { noremap = true })
keymap.set("n", "p", "\"0p", { noremap = true })

-- view
keymap.set("n", "<CR>", ":nohlsearch<CR><CR>", { noremap = true, silent = true })

-- disable
keymap.set("n", "q", "<NOP>", { noremap = true, silent = true })

-- neovide
if vim.g.neovide then
    keymap.set("n", "<F11>", [[<cmd>lua SwitchScreenMode()<CR>]])
    function SwitchScreenMode()
        if vim.g.neovide_fullscreen == true then
            vim.g.neovide_fullscreen = false
        else
            vim.g.neovide_fullscreen = true
        end
    end
end

-- test
keymap.set("n", "<leader>y", ":lua Test()<CR>", { silent = true })

function Test()
end
