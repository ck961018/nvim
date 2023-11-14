return {
    {
        "folke/tokyonight.nvim",
        dependencies = {
            "nvim-lualine/lualine.nvim",
            "utilyre/barbecue.nvim",
            "nvim-tree/nvim-web-devicons",
            "SmiteshP/nvim-navic",
        },
        config = function()
            vim.cmd [[colorscheme tokyonight-moon]]
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                },
            })
            require("barbecue").setup({
                theme = "tokyonight",
            })
        end
    },
}
