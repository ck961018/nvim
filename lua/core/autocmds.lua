-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = "*",
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
--     end,
-- })

local get_nvim_num = function()
    local tasklist = vim.fn.systemlist([[tasklist /FI "IMAGENAME eq nvim.exe" /NH]])
    local num = 0
    for _, line in ipairs(tasklist) do
        if string.find(line, [[nvim.exe]]) then
            num = num + 1
        end
    end
    return num
end

local get_autohotkey_pid = function()
    local tasklist = vim.fn.systemlist([[tasklist /FI "IMAGENAME eq AutoHotkey64.exe" /NH]])

    local pid = nil
    for _, line in ipairs(tasklist) do
        local fields = {}
        for field in string.gmatch(line, "[^%s]+") do
            table.insert(fields, field)
        end

        if #fields >= 2 and fields[1] == "AutoHotkey64.exe" then
            pid = tonumber(fields[2])
            break
        end
    end
    return pid
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local job_id = get_autohotkey_pid()
        if job_id == nil then
            local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
            local exe = autohotkey_path .. [[/AutoHotKey64.exe]]
            local script = autohotkey_path .. [[/Cap2EscAndCtrl.ahk]]
            vim.fn.jobstart(exe .. " " .. script)
        end
    end
})

vim.api.nvim_create_autocmd({ "ExitPre" }, {
    callback = function()
        local nvim_num = get_nvim_num()

        if nvim_num == 1 then
            local pid = get_autohotkey_pid()
            local cmd = string.format([[taskkill /F /PID %d]], pid)
            vim.fn.system(cmd)
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
