return {
    "voldikss/vim-translator",
    config = function()
        vim.keymap.set("n", "<leader>tr", [[<cmd>TranslateW<CR>]], { desc = "[Tr]anslate" })
        vim.keymap.set("v", "<leader>tr", [[<cmd>'<,'>TranslateW<CR>]], { desc = "[Tr]anslate" })
    end
}
