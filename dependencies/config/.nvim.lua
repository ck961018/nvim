local prog = "tmp_cmake.exe"

local release_path = vim.fn.getcwd() .. [[/build/bin/Release/]] .. prog
local debug_path = vim.fn.getcwd() .. [[/build/bin/Debug/]] .. prog

local dap = require('dap')
dap.configurations.cpp = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = debug_path,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        integratedTerminal = true,
    },
}

local release = function()
    require("async")(function()
        local command = nil
        if System == "wsl" then
            local path = vim.fn.system("wslpath -w " .. release_path)
            command = "cmd.exe /C 'start " .. path .. "' &"
        else
            command = "start " .. release_path
        end
        os.execute(command)
    end)
end

local debug = function()
    if require("dap").session() == nil then
        local tasklist = vim.fn.systemlist([[tasklist /FI "IMAGENAME eq codelldb.exe" /NH]])
        local pid = nil
        for _, line in ipairs(tasklist) do
            local fields = {}
            for field in string.gmatch(line, "[^%s]+") do
                table.insert(fields, field)
            end

            if #fields >= 2 and fields[1] == "codelldb.exe" then
                pid = tonumber(fields[2])
                break
            end
        end
        if pid ~= nil then
            local cmd = string.format([[tskill %d]], pid)
            vim.fn.jobstart(cmd)
        end

        local command = require("dap").adapters.codelldb.command
        local port = require("dap").adapters.codelldb.port
        vim.fn.jobstart(command .. [[ --port ]] .. tostring(port))
    end
    require("dap").continue()
end

Launch = function()
    local type = require("cmake-tools").get_build_type()
    vim.print(type)
    if type == "Release" then
        release()
    else
        debug()
    end
end
