return {
    {
        "keaising/im-select.nvim",
        event = "LazyFile",
        opts = {},
    },
    {
        "vidocqh/auto-indent.nvim",
        event = "InsertEnter",
        config = function()
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
        opts = {},
    },
}
