return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lua_ls = {},
                clangd = {
                    keys = {
                        { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=never",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    filetypes = { "c", "cpp", "objc", "objcpp", "h" },
                    on_new_config = function(new_config, _)
                        local status, cmake = pcall(require, "cmake-tools")
                        if status then
                            cmake.clangd_on_new_config(new_config)
                        end
                    end,
                },
                rust_analyzer = {},
            },
        },
    },
    {
        "iamcco/ds-pinyin-lsp",
        config = function()
            local db_directory = vim.fn.stdpath("config") .. "/dependencies/db"
            local db_path = db_directory .. "/dict.db3"
            if vim.fn.filereadable(db_path) == 0 then
                local unzip_cmd = string.format("tar -xzf %s -C %s", db_path .. ".zip", db_directory)
                vim.fn.system(unzip_cmd)
            end

            require("lspconfig").ds_pinyin_lsp.setup({
                cmd = vim.g.system == "wsl"
                        and { vim.fn.stdpath("config") .. "/dependencies/env/wsl/bin/ds-pinyin-lsp" }
                    or { vim.fn.stdpath("config") .. "/dependencies/env/win64/bin/ds-pinyin-lsp.exe" },
                filetypes = { "*" },
                init_options = {
                    db_path = db_path,
                    completion_on = true,
                    match_as_same_as_input = true,
                    max_suggest = 30,
                },
            })
        end,
    },
}
