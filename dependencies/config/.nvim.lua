local keymap = vim.keymap

local exe = "main.exe"

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
    },
}

local release = function()
    return require("async")(function()
        os.execute("start " .. release_path)
    end)
end

local debug = function()
    local tasklist = vim.fn.systemlist([[tasklist /FI "IMAGENAME eq codelldb.exe" /NH]])
    local is_running = false
    for _, line in ipairs(tasklist) do
        if string.find(line, [[codelldb.exe]]) then
            is_running = true
        end
    end
    if is_running == false then
        local command = require("dap").adapters.codelldb.command
        local port = require("dap").adapters.codelldb.port
        vim.fn.jobstart(command .. [[ --port ]] .. tostring(port))
    end
    require("dap").continue()
end

keymap.set("n", "<C-F5>", release, { noremap = true, silent = true })
keymap.set("n", "<F5>", debug, { noremap = true, silent = true })
