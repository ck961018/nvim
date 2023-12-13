local keymap = vim.keymap

local exe = "exe"

local release_path = vim.fn.getcwd() .. [[\build\bin\Release\]] .. exe
local debug_path = vim.fn.getcwd() .. [[\build\bin\Debug\]] .. exe

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
    return require("async")(function()
        os.execute("start " .. release_path)
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

keymap.set("n", "<C-F5>", release, { noremap = true, silent = true })
keymap.set("n", "<F5>", debug, { noremap = true, silent = true })
