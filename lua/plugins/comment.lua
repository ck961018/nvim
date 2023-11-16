return {
    {
        'numToStr/Comment.nvim',
        lazy = false,
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({
                gui_style = {
                    fg = "NONE", -- The gui style to use for the fg highlight group.
                    bg = "BOLD", -- The gui style to use for the bg highlight group.
                },
                highlight = {
                    keyword = "bg",
                    pattern = [[.*<(KEYWORDS)\s*]],
                },
                search = {
                    pattern = [[\b(KEYWORDS)\b]],
                }
            })
            vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "[T]odo[T]elescope" })
        end,
    },
}
