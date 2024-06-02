return {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
        local cmp = require("cmp")
        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if vim.snippet.active({ direction = 1 }) then
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if vim.snippet.active({ direction = -1 }) then
                    vim.schedule(function()
                        vim.snippet.jump(-1)
                    end)
                else
                    fallback()
                end
            end, { "i", "s" }),
        })
    end,
}
