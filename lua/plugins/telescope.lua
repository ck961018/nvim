return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    keys = {
        {
            "<leader>ff",
            mode = "v",
            function()
                vim.api.nvim_input("<esc>")
                vim.schedule(function()
                    local visual_selection = require("config.utils").get_visual_selection()
                    require("telescope.builtin").find_files()
                    vim.api.nvim_input(visual_selection)
                end)
            end,
            desc = "Find Files (Root Dir)",
        },
        {
            "<leader>sg",
            mode = "v",
            function()
                vim.api.nvim_input("<esc>")
                vim.schedule(function()
                    local visual_selection = require("config.utils").get_visual_selection()
                    require("telescope.builtin").live_grep()
                    vim.api.nvim_input(visual_selection)
                end)
            end,
            desc = "Grep (Root Dir)",
        },
    },
}
