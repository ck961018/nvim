return {
    {
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "jakewvincent/mkdnflow.nvim",
        event = "VeryLazy",
        rocks = "luautf8",
        config = function()
            require("mkdnflow").setup()
        end,
    },
}
