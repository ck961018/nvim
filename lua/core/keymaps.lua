local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("n", "<leader>w", [[<cmd>w<CR>]], { noremap = true, silent = true, desc = "Save Buffer" })

vim.keymap.set("n", "<leader><TAB>", function()
    if vim.bo.mod then
        vim.cmd.w()
    end
    SaveSession()
    vim.cmd.qa()
end, { desc = "Exit" })

-- spilt
keymap.set("n", "<leader>sv", [[<C-w>v]])
keymap.set("n", "<leader>sx", [[<cmd>close<CR>]])

-- move
keymap.set("n", "<A-h>", "<C-w>h")
keymap.set("n", "<A-l>", "<C-w>l")
keymap.set("n", "<A-j>", "<C-w>j")
keymap.set("n", "<A-k>", "<C-w>k")
keymap.set({ "n", "v" }, "<C-j>", "10jzz", { noremap = true, silent = true })
keymap.set({ "n", "v" }, "<C-k>", "10kzz", { noremap = true, silent = true })

-- edit
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true })
keymap.set({ "n", "v" }, "<leader>p", [["+p]], { noremap = true, silent = true })

-- view
keymap.set("n", "<CR>", [[<cmd>nohlsearch<CR><CR>]], { noremap = true, silent = true })

-- disable
keymap.set("n", "q", "<NOP>", { noremap = true, silent = true })

-- neovide
if vim.g.neovide then
    keymap.set("n", "<C-F11>", [[<cmd>lua SwitchScreenMode()<CR>]])
    function SwitchScreenMode()
        if vim.g.neovide_fullscreen == true then
            vim.g.neovide_fullscreen = false
        else
            vim.g.neovide_fullscreen = true
        end
    end
end

-- test
local get_info = function()
    local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
    local file = io.open(autohotkey_path .. "/pid", "rb")
    if file~=nil then
        local pid = file:read("*n")
        local nvim_num = file:read("*n")
        file:close()
        return pid, nvim_num
    end
    return nil
end
Test = function()
    -- local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
    -- local file = io.open(autohotkey_path .. "/pid", "wb")
    -- if file~=nil then
    --     file:write("10 10")
    --     file:close()
    -- end
    local a, b = get_info()
    vim.print(a, b)
end

keymap.set({ "n" }, "<leader>/", [[<cmd>lua Test()<CR>]], { silent = true })
