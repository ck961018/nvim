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
                        if vim.bo[buf_number].filetype ~= "cmake_tools_terminal" then
                            return true
                        end
                    end,
                }
            })
            vim.keymap.set("n", "g1", "<cmd>BufferLineGoToBuffer 1<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g2", "<cmd>BufferLineGoToBuffer 2<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g3", "<cmd>BufferLineGoToBuffer 3<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g4", "<cmd>BufferLineGoToBuffer 4<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g5", "<cmd>BufferLineGoToBuffer 5<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g6", "<cmd>BufferLineGoToBuffer 6<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g7", "<cmd>BufferLineGoToBuffer 7<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g8", "<cmd>BufferLineGoToBuffer 8<cr>", { noremap = true, silent = true })
            vim.keymap.set("n", "g9", "<cmd>BufferLineGoToBuffer 999999999<cr>", { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>q", "<cmd>w<cr><cmd>lua QuitBuffer()<cr>", { noremap = true, silent = true })

            function QuitBuffer()
                local buffer_line = require("bufferline")
                local elements = buffer_line.get_elements().elements
                local cnt = #elements

                if cnt > 1 then
                    local cur_pos
                    local cur_id = vim.fn.bufnr()
                    for i, e in ipairs(elements) do
                        if e.id == cur_id then
                            cur_pos = i
                            break
                        end
                    end
                    if cur_pos == cnt then
                        vim.cmd("BufferLineGoToBuffer " .. cur_pos - 1)
                    else
                        vim.cmd("BufferLineGoToBuffer " .. cur_pos + 1)
                    end
                    vim.cmd("bd " .. cur_id)
                else
                    vim.cmd("qa")
                end
            end
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function()
                    local gs = package.loaded.gitsigns
                    gs.toggle_current_line_blame()
                end
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
        "anuvyklack/pretty-fold.nvim",
        config = true,
    },
    {
        "anuvyklack/fold-preview.nvim",
        config = function()
            local fp = require("fold-preview")

            fp.setup({
                default_keybindings = false
            })
            vim.keymap.set("n", "<leader>pf", fp.toggle_preview)
        end
    },
}
