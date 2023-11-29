return {
    {
        'numToStr/Comment.nvim',
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>tl", [[<cmd>TodoTelescope<CR>]], desc = "[T]odo [L]ist" },
        },
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
        end,
    },
}
