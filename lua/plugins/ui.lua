function QuitBuffer()
    local cur_id = vim.fn.bufnr()

    if vim.tbl_contains(IgnoredFiletypes, vim.bo[cur_id].filetype) == false and vim.bo[cur_id].ft ~= "" then
        vim.cmd.w()
    end

    local bufs_list = require("barbar.state").get_buffer_list()
    local found = false
    for _, buf_id in ipairs(bufs_list) do
        if buf_id == cur_id then
            found = true
            break
        end
    end

    if #vim.api.nvim_list_wins() > 1 and found == false then
        vim.cmd.q()
    elseif #bufs_list == 1 and found then
        vim.cmd.qa()
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
                    preset = "default"
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
        -- TODO 缩进存在bug，此插件正在尝试解决
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        --     config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end
    },
    {
        -- TODO 切换目录后快捷键失效
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
}
