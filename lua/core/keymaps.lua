local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("n", "<leader>w", [[<cmd>w<CR>]], { noremap = true, silent = true })

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

keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true })
keymap.set({ "n", "v" }, "<leader>p", [["+p]], { noremap = true })

-- view
keymap.set("n", "<CR>", [[<cmd>nohlsearch<CR><CR>]], { noremap = true, silent = true })

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
Test = function()
    local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
    local file = io.open(autohotkey_path .. [[/JobId]], "r")
    local job_id, nvim_num
    if file ~= nil then
        job_id = file:read("*n")
        nvim_num = file:read("*n")
        file:close()
    end

    vim.print(job_id, nvim_num)
    if job_id == 0 then
        local exe = autohotkey_path .. [[/AutoHotKey64.exe]]
        local script = autohotkey_path .. [[/Cap2EscAndCtrl.ahk]]
        job_id = tostring(vim.fn.jobstart(exe .. " " .. script))
    end

    file = io.open(autohotkey_path .. [[/JobId]], "w")
    if file ~= nil then
        file:write(job_id)
        file:write(" ")
        file:write(nvim_num + 1)
        file:close()
    end
end

keymap.set({ "n" }, "<leader>/", [[<cmd>lua Test()<CR>]], { silent = true })
