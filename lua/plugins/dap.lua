return {
    -- TODO
    --
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        -- { "<F5>",       function() require("dap").continue() end },
        { "<F10>",      function() require("dap").step_over() end },
        { "<F11>",      function() require("dap").step_into() end },
        { "<F12>",      function() require("dap").step_out() end },
        { "<Leader>b",  function() require("dap").toggle_breakpoint() end },
        { "<Leader>lp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end },
        { "<Leader>dr", function() require("dap").repl.open() end },
        { "<Leader>dl", function() require("dap").run_last() end },
        {
            "<Leader>dh",
            function()
                require("dap.ui.widgets").hover()
            end,
            mode = { "n", "v" }
        },
        {
            "<Leader>dp",
            function()
                require("dap.ui.widgets").preview()
            end,
            mode = { "n", "v" }
        },
        { "<Leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end },
        { "<Leader>ds", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end },
    },
    config = function()
        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapUIStop", linehl = "", numhl = "", culhl = "" })
        vim.fn.sign_define("DapStopped", { text = "", texthl = "DapUIPlayPause", linehl = "", numhl = "", culhl = "" })

        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        require("nvim-dap-virtual-text").setup({})
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        if vim.fn.has("win32") then
            dap.adapters.codelldb = {
                type = "server",
                port = 13000,
                command = vim.fn.stdpath("config") ..
                    "\\dependencies\\bin\\Win64\\codelldb-x86_64-windows\\extension\\adapter\\codelldb.exe",
                args = { "--port", "${port}" },
                detached = false,
            }
        end

        dap.defaults.fallback.focus_terminal = true
    end
}
