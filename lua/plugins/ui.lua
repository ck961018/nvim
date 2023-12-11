function QuitBuffer()
    local bufs_list = require("barbar.state").get_buffer_list()
    if #bufs_list == 0 then
        vim.cmd.qa()
        return
    end

    local cur_id = vim.fn.bufnr()
    if vim.tbl_contains(IgnoredFiletypes, vim.bo[cur_id].filetype) == false and vim.bo[cur_id].ft ~= "" and vim.bo[cur_id].mod then
        vim.cmd.w()
    end

    local wins_list = vim.api.nvim_list_wins()
    local found = false
    local buf_found = false
    for _, buf_id in ipairs(bufs_list) do
        if buf_id == cur_id then
            found = true
            break
        end
    end

    for _, win_id in ipairs(wins_list) do
        local buf_id = vim.api.nvim_win_get_buf(win_id)
        if vim.tbl_contains(bufs_list, buf_id) then
            buf_found = true
            break
        end
    end


    if #wins_list > 1 and found == false and buf_found == true then
        vim.cmd.close()
    elseif #bufs_list == 1 and found then
        vim.cmd.qa()
    elseif vim.bo[cur_id].ft == "" then
        vim.cmd.BufferGoto(1)
        vim.cmd([[bd! ]] .. cur_id)
    else
        vim.cmd.BufferClose()
    end
end

return {
    {
        "romgrk/barbar.nvim",
        event = "VeryLazy",
        dependencies = {
            "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        config = function()
            require("barbar").setup({
                clickable = true,
                sidebar_filetypes = {
                    -- Use the default values: {event = 'BufWinLeave', text = nil}
                    NvimTree = { event = 'BufWinLeave', text = "NvimTree" },
                },
                icons = {
                    diagnostics = {
                        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " ! " },
                        [vim.diagnostic.severity.WARN] = { enabled = true, icon = " * " },
                        [vim.diagnostic.severity.INFO] = { enabled = true, icon = " i " },
                        [vim.diagnostic.severity.HINT] = { enabled = true, icon = " ? " },
                    },
                    filetype = {
                        -- Sets the icon's highlight group.
                        -- If false, will use nvim-web-devicons colors
                        custom_colors = false,

                        -- Requires `nvim-web-devicons` if `true`
                        enabled = true,
                    },
                    preset = "default",
                    separator = { left = "", right = "" },
                    separator_at_end = false,
                    inactive = { button = "" },
                },
                exclude_ft = IgnoredFiletypes,
            })

            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "g1", "<cmd>BufferGoto 1<CR>", opts)
            vim.keymap.set("n", "g2", "<cmd>BufferGoto 2<CR>", opts)
            vim.keymap.set("n", "g3", "<cmd>BufferGoto 3<CR>", opts)
            vim.keymap.set("n", "g4", "<cmd>BufferGoto 4<CR>", opts)
            vim.keymap.set("n", "g5", "<cmd>BufferGoto 5<CR>", opts)
            vim.keymap.set("n", "g6", "<cmd>BufferGoto 6<CR>", opts)
            vim.keymap.set("n", "g7", "<cmd>BufferGoto 7<CR>", opts)
            vim.keymap.set("n", "g8", "<cmd>BufferGoto 8<CR>", opts)
            vim.keymap.set("n", "g9", "<cmd>BufferGoto 9<CR>", opts)

            vim.keymap.set("n", "gt", "<cmd>BufferNext<CR>", opts)
            vim.keymap.set("n", "gT", "<cmd>BufferPrevious<CR>", opts)

            vim.keymap.set({ "n", "v" }, "<leader>q", "<cmd>lua QuitBuffer()<CR>", opts)
        end,
        version = '^1.0.0',
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        config = true,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            startify.config.opts.autostart = true
            alpha.setup(startify.config)
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure()
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        dependencies = {
            -- 该插件与其它异步插件可能会产生冲突
            "kevinhwang91/promise-async",
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("ufo").setup({
                provider_selector = function()
                    return { "treesitter", "indent" }
                end,
            })
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
        end,

    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    progress = {
                        enabled = true,
                        format = "lsp_progress",
                        format_done = "lsp_progress_done",
                        throttle = 2000 / 30, -- frequency to update lsp progress message
                        view = "mini",
                    },
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    signature = {
                        auto_open = {
                            trigger = false,
                        },
                    },
                    format = {
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
                routes = {
                    {
                        view = "mini",
                        filter = { event = "lsp", min_length = 80 },
                        opts = { skip = true }
                    },
                    {
                        view = "notify",
                        filter = { event = "msg_show", find = [[.*buffers wiped out]] },
                        opts = { skip = true }
                    }
                },
            })
        end,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            {
                "MunifTanjim/nui.nvim",
                event = "VeryLazy"
            },
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },
}
