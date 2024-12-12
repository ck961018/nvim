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
   }
}
