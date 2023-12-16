return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "SmiteshP/nvim-navic",
        },
        config = function()
            require("tokyonight").setup({
                style = "moon",
                styles = {
                    comments = { italic = false },
                },
                on_highlights = function(hl, c)
                    hl.DiagnosticUnnecessary  = {
                        fg = c.comment,
                    }
                end
            })
            vim.cmd([[colorscheme tokyonight]])
        end
    },
    {
        "utilyre/barbecue.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            theme = "tokyonight",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            options = {
                theme = "tokyonight",
            },
        },
    }
}
