-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = "*",
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
--     end,
-- })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
        local file = io.open(autohotkey_path .. [[/JobId]], "r")
        local job_id, nvim_num
        if file ~= nil then
            job_id = file:read("*n")
            nvim_num = file:read("*n")
            file:close()
        end

        if job_id == 0 then
            local exe = autohotkey_path .. [[/AutoHotKey64.exe]]
            local script = autohotkey_path .. [[/Cap2EscAndCtrl.ahk]]
            job_id = tostring(vim.fn.jobstart(exe .. " " .. script))
        end

        file = io.open(autohotkey_path .. [[/JobId]], "w")
        if file ~= nil then
            file:write(job_id)
            file:write(" ")
            file:write(nvim_num + 1)
            file:close()
        end
    end
})

vim.api.nvim_create_autocmd({"ExitPre"}, {
    callback = function()
        local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
        local file = io.open(autohotkey_path .. [[/JobId]], "r")
        local job_id, nvim_num
        if file ~= nil then
            job_id = file:read("*n")
            nvim_num = file:read("*n")
            file:close()
        end

        if nvim_num == 1 then
            vim.fn.jobstop(job_id)
            job_id = 0
        end

        file = io.open(autohotkey_path .. [[/JobId]], "w")
        if file ~= nil then
            file:write(job_id)
            file:write(" ")
            file:write(nvim_num - 1)
            file:close()
        end
    end
})

if vim.g.neovide then
    local function set_ime(args)
        if args.event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end

    local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        group = ime_input,
        pattern = "*",
        callback = function()
            vim.g.neovide_input_ime = false
        end
    })

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = set_ime
    })

    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = set_ime
    })
end
