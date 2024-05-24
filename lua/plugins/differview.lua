return {
    {
        "sindrets/diffview.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>dg", [[<cmd>DiffviewOpen<CR>]], desc = "[D]iffview [G]it" },
            { "<leader>dh", [[<cmd>DiffviewFileHistory %<CR>]], desc = "[D]iffview [H]istory" },
            { "<leader>dx", [[<cmd>DiffviewClose<CR>]], desc = "[D]iffview Close[X]" },
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
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            defaults = {
                ["<leader>d"] = { name = "+diffview" },
            },
        }
    },
}
