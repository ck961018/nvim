return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "elixir", "heex", "html", "markdown", "markdown_inline" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
}
