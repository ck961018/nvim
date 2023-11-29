TranslateSelectedText = function()
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
end
return {
    "voldikss/vim-translator",
    config = function()
        vim.keymap.set("n", "<leader>tr", [[<cmd>TranslateW<CR>]], { desc = "[Tr]anslate", noremap = true, silent = true })
        vim.keymap.set("v", "<leader>tr", [[<Esc><cmd>lua TranslateSelectedText()<CR>]], { desc = "[Tr]anslate", noremap = true, silent = true})
    end
}
