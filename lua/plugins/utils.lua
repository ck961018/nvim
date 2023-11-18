return {
    {
        "windwp/nvim-autopairs",
        opts = {
            enable_check_bracket_line = false,
            ignored_next_char = "[%w%.]",
            check_ts = true,
            fast_wrap = {},
        },
    },
    {
        "ethanholz/nvim-lastplace",
        config = true,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = { "o", },          function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require("nvim-tree").setup({

                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")
                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end

                    api.config.mappings.default_on_attach(bufnr)
                    vim.keymap.set("n", "<leader>e", api.tree.close, opts("Close"))
                    vim.keymap.set("n", "<leader>q", api.tree.close, opts("Close"))
                end,
                view = {
                    width = 30,
                    adaptive_size = true,
                    signcolumn = "yes",
                    preserve_window_proportions = true,
                },
                filters = {
                    git_ignored = false,
                },
                renderer = {
                    group_empty = false,
                },
                actions = {
                    open_file = {
                        resize_window = false,
                    },
                },

                -- for project
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
            })
            vim.keymap.set({ "n" }, "<leader>e", "<cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })
        end
    },
    -- Doxygen插件
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup({})
            vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({type = 'class'})<CR>",
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({type = 'func'})<CR>",
                { noremap = true, silent = true })
        end,
    },
    -- 代码大纲
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("aerial").setup({
                keymaps = {
                    ["<leader>a"] = "actions.close",
                },
            })
            vim.keymap.set("n", "<leader>a", "<cmd>AerialOpen<CR>")
        end,
    },
    {
        -- TODO new session manager
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {},
    },
}
