SaveSession = function()
    local bufs_of_barbar = require("barbar.state").get_buffer_list()
    local wins_list = vim.api.nvim_list_wins()

    if #bufs_of_barbar == 0 then
        return
    end

    for _, win in ipairs(wins_list) do
        local buf_of_win = vim.api.nvim_win_get_buf(win)
        if vim.tbl_contains(bufs_of_barbar, buf_of_win) == false then
            vim.api.nvim_win_close(win, true)
        end
    end

    local bufs_list = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs_list) do
        if vim.tbl_contains(IgnoredFiletypes, vim.bo[buf].filetype) then
            vim.cmd("bd!" .. tostring(buf))
        end
    end

    if vim.bo[vim.fn.bufnr()].filetype ~= "" then
        local project_path = vim.fn.getcwd()
        ---@diagnostic disable-next-line: param-type-mismatch
        local project_name = string.match(project_path, "[/\\]([^/\\]+)$")
        require("mini.sessions").write(project_name)
    end
end

RestoreSession = function()
    local project_path = vim.fn.getcwd()
    ---@diagnostic disable-next-line: param-type-mismatch
    local project_name = string.match(project_path, "[/\\]([^/\\]+)$")

    require("nvim-tree").change_dir(project_path)

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

    local nvim_lua_path = project_path .. "/.nvim.lua"
    if vim.fn.filereadable(nvim_lua_path) == 1 then
        vim.cmd.so(".nvim.lua")
        vim.notify(".nvim.lua is loaded")
    end

    -- fix lsp
    vim.cmd.e()
end

return {
    {
        "windwp/nvim-autopairs",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            enable_check_bracket_line = false,
            ignored_next_char = "[%w%.]",
            check_ts = true,
            fast_wrap = {},
        },
    },
    {
        "vladdoster/remember.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {}
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = { "o", },          function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        opts = {
            labels = "abcdefghijklmnopqrstuvwxyz",
            search = {
                mode = "extra",
            },
            label = {
                after = false,
                before = true,
            }
        },
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

                    vim.keymap.del("n", "<C-k>", { buffer = bufnr })
                    vim.keymap.set({ "n", "v" }, "<C-k>", "10kzz", { noremap = true, silent = true })

                    vim.keymap.set("n", "i", api.node.show_info_popup, opts("Info"))

                    vim.keymap.set("n", "<leader>e", api.tree.close, opts("Close"))
                    vim.keymap.set("n", "<leader>q", api.tree.close, opts("Close"))
                    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
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
                -- sync_root_with_cwd = true,
                -- respect_buf_cwd = true,
                -- update_focused_file = {
                --     enable = true,
                --     update_root = true,
                -- },
            })
        end
    },
    -- Doxygen插件
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>nc", [[<cmd>lua require("neogen").generate({type = "class"})<CR>]],
                { desc = "[N]eogen [C]lass Doxygen", noremap = true, silent = true }
            },
            {
                "<leader>nf", [[<cmd>lua require("neogen").generate({type = "func"})<CR>]],
                { desc = "[N]eogen [F]unction Doxygen", noremap = true, silent = true }
            },
        },
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup({})
        end,
    },
    -- 代码大纲
    {
        "simrat39/symbols-outline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("symbols-outline").setup({
                keymaps = {
                    close = { "<leader>q", "q" },
                }
            })
            ToggleSymbolsOutline = function()
                local so = require("symbols-outline")
                local so_win = so.view.winnr
                if so_win == nil then
                    so.open_outline()
                else
                    local cur_win = vim.api.nvim_get_current_win()
                    if cur_win == so_win then
                        so.close_outline()
                    else
                        vim.api.nvim_set_current_win(so_win)
                    end
                end
            end
            vim.keymap.set("n", "<leader>o", ToggleSymbolsOutline, { desc = "Symbols [O]utline" })
        end
    },
    -- 会话管理
    {
        "echasnovski/mini.sessions",
        event = "VeryLazy",
        version = false,
        config = function()
            require("mini.sessions").setup({
                autoread = false,
                autowrite = false,
                force = { read = true, write = true, delete = true },
                verbose = { read = false, write = false, delete = false },
                directory = vim.fn.stdpath("data") .. "/sessions",
                file = "",
                hooks = {
                    pre = { read = nil, write = nil, delete = nil },
                    post = { read = nil, write = nil, delete = nil },
                },
            })
            vim.keymap.set("n", "<leader>rs", RestoreSession, { desc = "[R]estore [S]ession" })
        end
    },
    -- 快捷键提示
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {},
    },
    -- 搜索
    {
        "nvim-pack/nvim-spectre",
        keys = {
            { "<leader>ss", mode = "n", [[<cmd>lua require("spectre").toggle()<CR>]],                             desc = "Spectr [S]earch" },
            { "<leader>sw", mode = "n", [[<cmd>lua require("spectre").open_visual({select_word=true})<CR>]],      desc = "Spectr [S]earch Current [W]ord" },
            { "<leader>sw", mode = "v", [[<ESC><cmd>lua require("spectre").open_visual()<CR>]],                   desc = "Spectr [S]earch Current [W]ord" },
            { "<leader>sb", mode = "n", [[<cmd>lua require("spectre").open_file_search({select_word=true})<CR>]], desc = "Spectr [S]earch in Current [B]uffers" },
        },
        config = function()
            require("spectre").setup({
                mapping = {
                    ['send_to_qf'] = {
                        map = "<leader>sq",
                        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                        desc = "[S]end all items to [Q]uickfix"
                    },
                }
            })
        end,
    },
    -- 浮窗控制台
    {
        "akinsho/toggleterm.nvim",
        keys = {
            { "<leader>tt", [[<cmd>ToggleTerm<CR>]], { desc = "[T]oggle[T]erm" } },
        },
        version = "*",
        config = function()
            require("toggleterm").setup({
                direction = "float",
                float_opts = {
                    border = "double",
                },
            })
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
                -- vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<CR>]], opts)
                -- vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<CR>]], opts)
                -- vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<CR>]], opts)
                -- vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<CR>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        end,
    },
    -- 自动缩进
    {
        "vidocqh/auto-indent.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("auto-indent").setup({
                lightmode = true,
                indentexpr = function(lnum)
                    ---@diagnostic disable-next-line: return-type-mismatch
                    return vim.fn.cindent(lnum)
                end,
                ignore_filetype = {}, -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
            })
        end
    },
    -- 智能识别缩进
    {
        "nmac427/guess-indent.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("guess-indent").setup({
                autocmd = true,
            })
        end
    },
    -- tmux
    {
        "aserowy/tmux.nvim",
        keys = {
            { "<M-h>", [[<cmd>lua require("tmux").move_left()<CR>]] },
            { "<M-j>", [[<cmd>lua require("tmux").move_bottom()<CR>]] },
            { "<M-k>", [[<cmd>lua require("tmux").move_top()<CR>]] },
            { "<M-l>", [[<cmd>lua require("tmux").move_right()<CR>]] },
            { "<M-H>", [[<cmd>lua require("tmux").resize_left()<CR>]] },
            { "<M-J>", [[<cmd>lua require("tmux").resize_bottom()<CR>]] },
            { "<M-K>", [[<cmd>lua require("tmux").resize_top()<CR>]] },
            { "<M-L>", [[<cmd>lua require("tmux").resize_right()<CR>]] },
        },
        config = function()
            require("tmux").setup({
                navigation = {
                    enable_default_keybindings = false,
                },
                resize = {
                    enable_default_keybindings = false,
                },
            })
            local status, which_key = pcall(require, "which-key")
            if status then
                vim.keymap.set("n", [["]], function()
                    if vim.env.TMUX then
                        require("tmux.copy").sync_registers()
                    end
                    which_key.show([["]], { mode = "n", auto = true })
                end)
                vim.keymap.set("x", [["]], function()
                    if vim.env.TMUX then
                        require("tmux.copy").sync_registers()
                    end
                    which_key.show([["]], { mode = "v", auto = true })
                end)
            end
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-surround").setup({
                move_cursor = false,
            })
        end
    },
    -- 编码检测
    -- {
    --     "mbbill/fencview",
    --     config = function()
    --         vim.g.fencview_autodetect = 1
    --     end
    -- }
}
