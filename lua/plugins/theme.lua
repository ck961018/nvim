return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
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
            })
            vim.cmd([[colorscheme tokyonight]])
        end
    },
    {
        "utilyre/barbecue.nvim",
        event = "VeryLazy",
        opts = {
            theme = "tokyonight",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "tokyonight",
            },
        },
    }
}
