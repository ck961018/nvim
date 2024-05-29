return {
    {
        "keaising/im-select.nvim",
        config = function()
            require("im_select").setup({
                default_command = vim.uv.os_uname().sysname == "Windows_NT"
                        and vim.fn.stdpath("config") .. "/dependencies/env/win64/bin/ds-pinyin-lsp.exe"
                    or "/dependencies/env/wsl/bin/ds-pinyin-lsp.exe",
            })
        end,
    },
}
