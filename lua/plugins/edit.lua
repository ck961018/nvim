return {
    {
        "keaising/im-select.nvim",
        config = function()
            require("im_select").setup({
                default_command = vim.uv.os_uname().sysname == "Windows_NT"
                        and vim.fn.stdpath("config") .. "/dependencies/env/win64/bin/im-select.exe"
                    or vim.fn.stdpath("config") .. "/dependencies/env/wsl/bin/im-select.exe",
            })
        end,
    },
}
