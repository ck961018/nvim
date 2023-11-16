return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        dependencies = {
            "nvim-lualine/lualine.nvim",
            "utilyre/barbecue.nvim",
            "nvim-tree/nvim-web-devicons",
            "SmiteshP/nvim-navic",
        },
        config = function()
            require("tokyonight").setup({
                style = "storm",
                styles = {
                    comments = { italic = false }
                }
            })
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                },
            })
            require("barbecue").setup({
                theme = "tokyonight",
            })
            vim.cmd [[colorscheme tokyonight]]
        end
    },
}
