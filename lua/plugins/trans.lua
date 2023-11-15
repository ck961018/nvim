vim.g.sqlite_clib_path = vim.fn.stdpath("config") ..
    "\\dependencies\\bin\\sqlite-dll-win-x64-3440000\\sqlite3.dll" --for sqlite3
return {
    "JuanZoran/Trans.nvim",
    dependencies = { "kkharji/sqlite.lua", },
    build = function() require("Trans").install() end,
    keys = {
        -- 可以换成其他你想映射的键
        { "mm", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = " Translate" },
        { "mk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
        -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
        -- { "mi", "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
    },
    config = function()
        require("Trans").setup({
            dir = vim.fn.stdpath("data") .. "/lazy/Trans.nvim/database",
            theme = "dracula",
            frontend = {
                default = {
                    query     = "fallback",
                    border    = "rounded",
                    title     = vim.fn.has "nvim-0.9" == 1 and {
                        { "", "TransTitleRound" },
                        { " Trans", "TransTitle" },
                        { "", "TransTitleRound" },
                    } or nil, -- need nvim-0.9+
                    auto_play = true,
                    ---@type {open: string | boolean, close: string | boolean, interval: integer} Hover Window Animation
                    animation = {
                        open = "slid", -- "fold", "slid"
                        close = "slid",
                        interval = 7,
                    },
                    timeout   = 2000,
                },
            },
        })
    end,
}
