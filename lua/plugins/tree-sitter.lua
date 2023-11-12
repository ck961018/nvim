return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "c_sharp", "cpp" },
        hightlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
}
