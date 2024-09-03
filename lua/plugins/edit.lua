return {
    {
        "vidocqh/auto-indent.nvim",
        event = "InsertEnter",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("auto-indent").setup({
                indentexpr = function(lnum)
                    return vim.fn.cindent(lnum)
                end,
            })
        end,
    },
    {
        "m4xshen/hardtime.nvim",
        event = "LazyFile",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {
            max_count = 100,
        },
    },
}
