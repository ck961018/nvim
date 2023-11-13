return {
    "Civitasv/cmake-tools.nvim",
    config = function()
        vim.keymap.set({ "n"}, "<c-F7>", "<cmd>CMakeGenerate<CR>")
        vim.keymap.set({ "n"}, "<F7>", "<cmd>CMakeBuild<CR>")
        vim.keymap.set({ "n"}, "<F5>", "<cmd>CMakeRun<CR>")
    end,
}
