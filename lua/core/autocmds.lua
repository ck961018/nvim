vim.api.nvim_create_autocmd({ "DirChanged" }, {
    callback = function()
        require("session_manager").load_current_dir_session()
        local nvim_lua_path = vim.fn.expand('%:p:h') .. '/.nvim.lua'
        if vim.fn.filereadable(nvim_lua_path) == 1 then
            vim.cmd.so(".nvim.lua")
            vim.print(".nvim.lua is loaded")
        end
    end,
})
