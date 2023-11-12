return {
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup {
                options = {
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            separator = true,
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
                }
            }
            vim.keymap.set('n', 'g1', '<cmd>BufferLineGoToBuffer 1<cr>', { noremap = true, silent = true })
            vim.keymap.set('n', 'g2', '<cmd>BufferLineGoToBuffer 2<cr>', { noremap = true, silent = true })
            vim.keymap.set('n', 'g3', '<cmd>BufferLineGoToBuffer 3<cr>', { noremap = true, silent = true })
            vim.keymap.set('n', 'g4', '<cmd>BufferLineGoToBuffer 4<cr>', { noremap = true, silent = true })
            vim.keymap.set('n', 'g5', '<cmd>BufferLineGoToBuffer 5<cr>', { noremap = true, silent = true })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require 'alpha'.setup(require 'alpha.themes.startify'.config)
        end,
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure()
        end,
    },
}
