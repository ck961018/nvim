return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
        config = function()
            require("telescope").setup {
                pickers = {
                    find_files = {
                        mappings = {
                            n = {
                                ["<leader>q"] = "close",
                            },
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    undo = {
                        mappings = {
                            i = {
                                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                                ["<C-cr>"] = require("telescope-undo.actions").restore,
                                -- alternative defaults, for users whose terminals do questionable things with modified <cr>
                                ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                                ["<C-r>"] = require("telescope-undo.actions").restore,
                            },
                            n = {
                                ["y"] = require("telescope-undo.actions").yank_additions,
                                ["Y"] = require("telescope-undo.actions").yank_deletions,
                                ["u"] = require("telescope-undo.actions").restore,
                            },
                        },
                    }
                }
            }
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("undo")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>?", builtin.oldfiles, {})

            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
        end,
    },
}
