-- TODO 当前project_nvim自动添加project，workspaces设置hooks
--      后续最好用集成了两个功能的插件替换
function ListProjects()
    local projects = require("project_nvim").get_recent_projects()
    local history_projects = require("workspaces").get()
    for _, project in ipairs(projects) do
        local found = false
        local project_name = string.match(project, "/([^/]+)$")
        for _, history_project in ipairs(history_projects) do
            local history_project_name = string.match(history_project.name, "%S+")
            if project_name == history_project_name then
                found = true
                break
            end
        end
        if found == false then
            require("workspaces").add(project, project_name)
        end
    end
    vim.cmd([[Telescope workspaces]])
end

return {
    "nvim-telescope/telescope.nvim",
    keys = {
        -- telescope
        { "<leader>ff", [[<cmd>Telescope find_files<CR>]], desc = "[F]ind [F]iles" },
        { "<leader>fg", [[<cmd>Telescope live_grep<CR>]],  desc = "[F]ind with [G]rep" },
        { "<leader>fb", [[<cmd>Telescope buffers<CR>]],    desc = "[F]ind in [B]uffers" },
        { "<leader>fh", [[<cmd>Telescope help_tags<CR>]],  desc = "[F]ind [H]elp Tags" },
        { "<leader>fo", [[<cmd>Telescope oldfiles]],       desc = "[F]ind [O]ldfiles" },

        -- telescope-undo
        { "<leader>u",  [[<cmd>Telescope undo<CR>]],       desc = "[U]ndo" },

        -- project
        { "<leader>p",  [[<cmd>lua ListProjects()<CR>]],   { desc = "[P]rojects", noremap = true, silent = true } }
    },
    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },

        -- project
        "ahmedkhalf/project.nvim",
        "natecraddock/workspaces.nvim",

        -- notify
        "rcarriga/nvim-notify",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    n = {
                        ["<leader>q"] = require("telescope.actions").close,
                    },
                }

            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },
                undo = {
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                    },
                },
            }

        })
        require("workspaces").setup({
            path = vim.fn.stdpath("data") .. "/project_nvim/workspaces.txt",
            auto_open = true,
            hooks = {
                add = {},
                remove = {},
                rename = {},
                open_pre = {},
                open = function()
                    local nvim_lua_path = vim.fn.expand('%:p:h') .. '/.nvim.lua'
                    if vim.fn.filereadable(nvim_lua_path) == 1 then
                        vim.cmd.so(".nvim.lua")
                        vim.notify(".nvim.lua is loaded")
                    end

                    RestoreSession()
                end,
            },
        })
        require("project_nvim").setup({
            detection_methods = { "pattern", },
            patterns = { ".git", ".clang-format", },
            show_hidden = true,
            open_file_finder = false,
            datapath = vim.fn.stdpath("data"),
        })
        vim.notify = require("notify")

        require("telescope").load_extension("workspaces")
        require("telescope").load_extension("projects")

        require("telescope").load_extension("notify")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("undo")
        require("telescope").load_extension("ui-select")
    end,
}
