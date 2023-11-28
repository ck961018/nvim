TranslateSelectedText = function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local selected_text = vim.fn.getline(start_line, end_line)
    vim.cmd.TranslateW(selected_text)
end
return {
    "voldikss/vim-translator",
    config = function()
        vim.keymap.set("n", "<leader>tr", [[<cmd>TranslateW<CR>]], { desc = "[Tr]anslate" })
        vim.keymap.set("v", "<leader>tr", TranslateSelectedText, { desc = "[Tr]anslate" })
    end
}
