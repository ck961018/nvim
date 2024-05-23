function ListProjects()
    local projects = require("persistence").list()
    local history_projects = require("workspaces").get()
    local visited = {}
    for _, project in ipairs(projects) do
        local found = false
        local project_path = string.match(project, "[\\/]([^\\^/]+)%.vim")
        project_path = string.gsub(project_path, "%%", "/")
        project_path = string.gsub(project_path, "//", ":/")
        local project_name = string.match(project_path, "[\\/]([^\\^/]+)$")
        for _, history_project in ipairs(history_projects) do
            local history_project_name = string.match(history_project.name, "%S+")
            if project_path == history_project_name then
                found = true
                break
            end
        end
        if found == false then
            require("workspaces").add(project_path, project_name)
        end
        visited[project_name] = true
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
                open = function()
                    require("persistence").load()
                end
            },
        })
        require("telescope").load_extension("workspaces")
    end
}
}
