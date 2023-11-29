local keymap = vim.keymap

vim.g.mapleader = " "

-- save
keymap.set("n", "<leader>w", "<cmd>w<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader><TAB>", function()
    if vim.bo.mod then
        vim.cmd.w()
    end
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
keymap.set({ "n", "v" }, "<A-j>", "10jzz")
keymap.set({ "n", "v" }, "<A-k>", "10kzz")

-- edit
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set({ "n", "v" }, "<leader>y", "\"+y", { noremap = true })
keymap.set({ "n", "v" }, "<leader>p", "\"+p", { noremap = true })

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

Test = function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local start_col = vim.fn.col("'<")
    local end_col = vim.fn.col("'>")

    local lines = vim.fn.getline(start_line, end_line)

    -- 如果只在同一行内选取，则截取选取的列范围
    if start_line == end_line then
        lines[1] = lines[1]:sub(start_col, end_col)
    else
        -- 如果在多行选取，则截取每一行的选取部分
        lines[1] = lines[1]:sub(start_col)
        lines[#lines] = lines[#lines]:sub(1, end_col)
    end

    -- 将获取到的文本连接成一个字符串并返回
    local selected_text = table.concat(lines, "\n")
    vim.cmd.TranslateW(selected_text)
    vim.print(selected_text)
end
keymap.set({ "n", "v" }, "<leader>/", [[:lua Test()<CR>]], { silent = true })

