function ListProjects()
    local projects = require("auto-session").get_session_files()
    local history_projects = require("workspaces").get()
    local visited = {}
    for _, project in ipairs(projects) do
        if project.display_name == nil then
            goto continue;
        end
        local found = false
        local project_name = string.match(project.display_name, "[\\/]([^\\^/]+)$")
        for _, history_project in ipairs(history_projects) do
            local history_project_name = string.match(history_project.name, "%S+")
            if project_name == history_project_name then
                found = true
                break
            end
        end
        if found == false then
            require("workspaces").add(project.display_name, project_name)
        end
        visited[project_name] = true
        ::continue::
    end

    for _, history_project in ipairs(history_projects) do
        local history_project_name = string.match(history_project.name, "%S+")
        if visited[history_project_name] == nil then
            require("workspaces").remove(history_project_name)
        end
    end

    vim.cmd([[Telescope workspaces]])
end

return {
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                auto_session_create_enabled = false,
                pre_save_cmds = {
                    function()
                        require("cmake-tools").close_runner()
                        require("neo-tree.command").execute({action = "close"})
                    end,
                },
            })
        end
    },
    {
        "natecraddock/workspaces.nvim",
        keys = {
            { "<leader>fp", ListProjects, desc = "Projects" },
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("workspaces").setup({
                path = vim.fn.stdpath("data") .. "/sessions/workspaces",
                auto_open = false,
                notify_info = false,
                hooks = {
                    add = {},
                    remove = {},
                    rename = {},
                    open_pre = {},
                    open = "SessionRestore",
                },
            })
            require("telescope").load_extension("workspaces")
        end
    }
}
