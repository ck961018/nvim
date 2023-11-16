vim.api.nvim_create_autocmd({ "DirChanged" }, {
    callback = function()
        local nvim_lua_path = vim.fn.expand('%:p:h') .. '/.nvim.lua'
        if vim.fn.filereadable(nvim_lua_path) == 1 then
            vim.cmd.so(".nvim.lua")
            vim.print(".nvim.lua is loaded")
        end
    end,
})

-- TODO 这个触发器解决第一次折叠会折叠所有代码的问题,
-- 但最好还是通过插件的设置解决。相关插件：tree-sitter和pretty-fold
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
        vim.api.nvim_feedkeys("za", "n", true)
        vim.api.nvim_feedkeys("zR", "n", true)
    end,
})
