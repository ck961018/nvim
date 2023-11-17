return {
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup({
                options = {
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            separator = true,
                            highlight = "Directory",
                            text_align = "left",
                        }
                    },
                    diagnostics = "nvim_lsp",
                    separator_style = { "", "" },
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    numbers = function(opts)
                        return opts.ordinal
                    end,
                    custom_filter = function(buf_number, _)
                        -- filter out filetypes you don't want to see
                        if vim.bo[buf_number].filetype ~= "cmake_tools_terminal" and vim.bo[buf_number].filetype ~= "qf" then
                            return true
                        end
                    end,
                }
            })
            vim.keymap.set({ "n", "v" }, "g1", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g2", "<cmd>BufferLineGoToBuffer 2<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g3", "<cmd>BufferLineGoToBuffer 3<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g4", "<cmd>BufferLineGoToBuffer 4<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g5", "<cmd>BufferLineGoToBuffer 5<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g6", "<cmd>BufferLineGoToBuffer 6<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g7", "<cmd>BufferLineGoToBuffer 7<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g8", "<cmd>BufferLineGoToBuffer 8<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "g9", "<cmd>BufferLineGoToBuffer 9<cr>", { noremap = true, silent = true })

            vim.keymap.set("n", "gt", "<cmd>BufferLineCycleNext<cr>")
            vim.keymap.set("n", "gT", "<cmd>BufferLineCyclePrev<cr>")

            vim.keymap.set({ "n", "v" }, "<leader>q", "<cmd>lua QuitBuffer()<cr>", { noremap = true, silent = true })

            function QuitBuffer()
                local buffer_line = require("bufferline")
                local elements = buffer_line.get_elements().elements
                local cnt = #elements
                local cur_id = vim.fn.bufnr()

                local ignored_filetypes = {
                    "",
                    "qf",
                    "lazy",
                    "help",
                    "alpha",
                    "aerial",
                    "camek_tools_terminal",
                }

                local is_ignored = function(str)
                    local found = false
                    for _, filetype in ipairs(ignored_filetypes) do
                        if (str == filetype) then
                            found = true
                            break
                        end
                    end
                    return found
                end

                if is_ignored(vim.bo[cur_id].filetype) == false then
                    vim.cmd("silent w")
                end

                local cur_pos = -1
                for i, e in ipairs(elements) do
                    if e.id == cur_id then
                        cur_pos = i
                        break
                    end
                end
                if cur_pos == -1 then
                    vim.cmd.q()
                    return
                end

                if cnt > 1 then
                    local nxt_pos;
                    if cur_pos == cnt then
                        nxt_pos = cur_pos - 1
                    else
                        nxt_pos = cur_pos + 1
                    end
                    if cnt == 2 and is_ignored(vim.bo[elements[nxt_pos].id].filetype) then
                        vim.cmd.qa()
                    else
                        vim.cmd.BufferLineGoToBuffer(nxt_pos)
                        vim.cmd.bd(cur_id)
                    end
                else
                    vim.cmd.qa()
                end
            end
        end,
    },
    -- TODO 缩进存在bug，此插件正在尝试解决
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        --     config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
            })
        end
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require "alpha.themes.startify".config)
        end,
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure()
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
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
