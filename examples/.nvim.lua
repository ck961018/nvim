local keymap = vim.keymap

local exe_path = [[path_to_exe]]
local async = require("async")
local buf_id

local wait_and_close = async.sync(function()
    os.execute("start " .. exe_path)
    vim.cmd("bd " .. buf_id)
end)

function StartCmdAndExe()
    local cur_id = vim.fn.winnr()

    for _, id in ipairs(vim.api.nvim_list_bufs()) do
        local buf = vim.bo[id]
        if (buf.filetype == "qf") then
            local nxt_id = vim.fn.bufwinnr(id)
            vim.cmd(nxt_id .. "wincmd w")
            buf_id = id
            wait_and_close()
            vim.cmd(cur_id .. "wincmd w")
            return
        end
    end

    vim.cmd("new")
    vim.bo.filetype = "qf"
    buf_id = vim.fn.bufnr();
    wait_and_close()
    vim.cmd(cur_id .. "wincmd w")
end

keymap.set("n", "<F5>", ":lua StartCmdAndExe()<CR>", { noremap = true, silent = true })
