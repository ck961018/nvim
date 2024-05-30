return {
    {
        "keaising/im-select.nvim",
        event = "LazyFile",
        config = function()
            require("im_select").setup({
                default_command = vim.uv.os_uname().sysname == "Windows_NT"
                        and vim.fn.stdpath("config") .. "/dependencies/env/win64/bin/im-select.exe"
                    or vim.fn.stdpath("config") .. "/dependencies/env/wsl/bin/im-select.exe",
            })
        end,
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
