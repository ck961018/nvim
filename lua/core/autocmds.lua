-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = "*",
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
--     end,
-- })

local read_hotkey_info = function()
    local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
    local file = io.open(autohotkey_path .. "/pid", "rb")
    if file ~= nil then
        local pid = file:read("*n")
        local nvim_num = file:read("*n")
        file:close()
        return pid, nvim_num
    end
    return nil
end

local write_hotkey_info = function(pid, nvim_num)
    local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
    local file = io.open(autohotkey_path .. "/pid", "wb")
    if file ~= nil then
        file:write(tostring(pid) .. " " .. tostring(nvim_num))
        file:close()
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        if vim.fn.has("win32") == 1 then
            local pid, nvim_num = read_hotkey_info()
            if pid == 0 then
                local autohotkey_path = vim.fn.stdpath("config") .. [[/dependencies/bin/Win64/AutoHotkey_2.0.10]]
                local exe = autohotkey_path .. [[/AutoHotKey64.exe]]
                local script = autohotkey_path .. [[/Cap2EscAndCtrl.ahk]]
                pid = vim.fn.jobstart(exe .. " " .. script)
            end
            write_hotkey_info(pid, nvim_num + 1)
        end
    end
})

vim.api.nvim_create_autocmd({ "ExitPre" }, {
    callback = function()
        if vim.fn.has("win32") == 1 then
            local pid, nvim_num = read_hotkey_info()
            if nvim_num == 1 and pid ~= 0 then
                vim.fn.jobstop(pid)
                pid = 0
            end
            write_hotkey_info(pid, nvim_num - 1)
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
