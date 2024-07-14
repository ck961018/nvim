return {
    {
        "sindrets/diffview.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>gd", "", desc = "+diffview" },
            { "<leader>gdg", [[<cmd>DiffviewOpen<CR>]], desc = "[D]iffview [G]it" },
            { "<leader>gdh", [[<cmd>DiffviewFileHistory %<CR>]], desc = "[D]iffview [H]istory" },
            { "<leader>gdx", [[<cmd>DiffviewClose<CR>]], desc = "[D]iffview Close[X]" },
        },
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                view = {
                    merge_tool = {
                        layout = "diff3_mixed",
                    },
                },
                keymaps = {
                    view = {
                        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel." } },
                        { "n", "<leader>b", false },
                    },
                    file_panel = {
                        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel." } },
                        { "n", "<leader>b", false },
                    },
                    file_history_panel = {
                        { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel." } },
                        { "n", "<leader>b", false },
                    },
                },
            })
        end,
    },
}
