SaveSession = function()
    local bufs_list = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs_list) do
        if vim.tbl_contains(IgnoredFiletypes, buf) then
            vim.cmd.bd(buf)
        end
    end
    if vim.bo[vim.fn.bufnr()].filetype ~= "" then
        local project_path = vim.fn.getcwd()
        local project_name = string.match(project_path, "\\([^\\]+)$")
        require("mini.sessions").write(project_name)
    end
end

LoadSession = function()
    local project_path = vim.fn.getcwd()
    local project_name = string.match(project_path, "\\([^\\]+)$")

    local found = false
    for session, _ in pairs(require("mini.sessions").detected) do
        if tostring(session) == project_name then
            found = true
            break
        end
    end
    if found == true then
        require("mini.sessions").read(project_name)
    end
end

return {
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        opts = {
            enable_check_bracket_line = false,
            ignored_next_char = "[%w%.]",
            check_ts = true,
            fast_wrap = {},
        },
    },
    {
        "ethanholz/nvim-lastplace",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
    {
        "folke/flash.nvim",
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = { "o", },          function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        opts = {},
    },
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<leader>e", [[<cmd>NvimTreeFocus<CR>]], { desc = "NvimTr[E]e", noremap = true, silent = true } },
        },
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
        end
    },
    -- Doxygen插件
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>nc", [[<cmd> require("neogen").generate({type = "class"})<CR>]],
                { desc = "[G]enerate [C]lass Doxygen", noremap = true, silent = true }
            },
            {
                "<leader>nf", [[<cmd> require("neogen").generate({type = "func"})<CR>]],
                { desc = "[G]enerate [F]unction Doxygen", noremap = true, silent = true }
            },
        },
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup({})
        end,
    },
    -- 代码大纲
    {
        "stevearc/aerial.nvim",
        keys = {
            { "<leader>a", [[<cmd>AerialOpen<CR>]], { desc = "[A]erial" } }
        },
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
        end,
    },
    {
        "echasnovski/mini.sessions",
        event = "VeryLazy",
        version = false,
        config = function()
            require("mini.sessions").setup({
                autoread = false,
                autowrite = true,
                force = { read = true, write = true, delete = true },
                verbose = { read = false, write = false, delete = true },
                directory = vim.fn.stdpath("data") .. "/sessions",
                file = "",
                hooks = {
                    pre = {
                        read = nil,
                        write = function()
                            if require("nvim-tree.view").is_visible() then
                                require("nvim-tree.view").close()
                            end
                        end,
                        delete = nil
                    },
                    post = { read = nil, write = nil, delete = nil },
                },
            })
            vim.keymap.set("n", "<leader>ls", LoadSession, { desc = "[L]oad [S]ession" })
        end
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
    {
        "nvim-pack/nvim-spectre",
        keys = {
            { "<leader>ss", mode = "n", [[<cmd>lua require("spectre").toggle()<CR>]],                             desc = "Spectr [S]earch" },
            { "<leader>sw", mode = "n", [[<cmd>lua require("spectre").open_visual({select_word=true})<CR>]],      desc = "Spectr [S]earch Current [W]ord" },
            { "<leader>sw", mode = "v", [[<ESC><cmd>lua require("spectre").open_visual()<CR>]],                   desc = "Spectr [S]earch Current [W]ord" },
            { "<leader>sb", mode = "n", [[<cmd>lua require("spectre").open_file_search({select_word=true})<CR>]], desc = "Spectr [S]earch in Current [B]uffers" },
        },
        config = function()
            require("spectre").setup()
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        keys = {
            { "<leader>tt", [[<cmd>ToggleTerm<CR>]], { desc = "[T]oggle[T]erm" } },
        },
        version = "*",
        config = function()
            require("toggleterm").setup({
                direction = "float",
            })
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end,
    },
}
