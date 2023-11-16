vim.api.nvim_exec_autocmds({ "DirChanged" }, {
    callback = function()
        local nvim_lua_path = vim.fn.expand('%:p:h') .. '/.nvim.lua'
        vim.notify(nvim_lua_path)
        vim.print(nvim_lua_path)
    end,
})

return {}