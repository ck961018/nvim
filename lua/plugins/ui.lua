return {
    {
        "folke/tokyonight.nvim",
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            flavour = "macchiato",
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
            -- colorscheme = "tokyonight",
        },
    },
}
