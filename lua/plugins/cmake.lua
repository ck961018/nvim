return {
    {
        "Civitasv/cmake-tools.nvim",
        keys = {
            -- { "<F5>", mode = { "n", "v" }, [[<cmd>CMakeRun<CR>]] },
            { "<F6>", mode = { "n", "v" }, [[<cmd>CMakeSelectCwd<CR>]] },
            { "<F7>", mode = { "n", "v" }, [[<cmd>CMakeBuild<CR>]] },

            -- { "<F5>", mode = "i", [[<ESC><cmd>CMakeRun<CR>]] },
            { "<F6>", mode = "i", [[<ESC><cmd>CMakeSelectCwd<CR>]] },
            { "<F7>", mode = "i", [[<ESC><cmd>CMakeBuild<CR>]] },
        },
        opts = {
            cmake_build_directory = "build", -- this is used to specify generate directory for cmake, allows macro expansion
            cmake_soft_link_compile_commands = false, -- this will automatically make a soft link from compile commands file to project root dir
            cmake_compile_commands_from_lsp = true, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
            cmake_executor = { -- executor to use
                name = "quickfix", -- name of the executor
                default_opts = { -- a list of default and possible values for executors
                    quickfix = {
                        encoding = "cp936",
                        auto_close_when_success = false,
                    },
                },
            },
        },
    },
}
