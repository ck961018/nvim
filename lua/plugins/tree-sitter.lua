return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    -- event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        -- TODO learn vim objects
        -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    opts = function(_, opts)
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "elixir", "heex", "html", "markdown", "markdown_inline" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = false },
        })
        if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, { "cmake" })
        end
        -- refer to the configuration section below
    end
}
