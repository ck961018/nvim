function ListProjects()
    local projects = require("persistence").list()
    local history_projects = require("workspaces").get()
    local visited = {}
    for _, project in ipairs(projects) do
        local project_path = project:match("[\\/]([^\\^/]+)%.vim")
        project_path = project_path:gsub("%%", "/")
        if LazyVim.is_win() then
            project_path = project_path:gsub("^(%w)/", "%1:/")
        end
        project_path = project_path:gsub("//.*", "")

        LazyVim.notify(project_path)

        local stat = vim.uv.fs_stat(project_path)
        if stat == nil then
            goto continue
        end

        local found = false
        local project_name = project_path:match("[\\/]([^\\^/]+)$")
        for _, history_project in ipairs(history_projects) do
            local history_project_name = history_project.name:match("%S+")
            if project_name == history_project_name then
                found = true
                break
            end
        end
        if found == false then
            require("workspaces").add(project_path, project_name)
        end
        visited[project_name] = true

        ::continue::
    end

    for _, history_project in ipairs(history_projects) do
        local history_project_name = history_project.name:match("%S+")
        if visited[history_project_name] == nil then
            require("workspaces").remove(history_project_name)
        end
    end

    vim.cmd([[Telescope workspaces]])
end

vim.api.nvim_create_autocmd("User", {
    pattern = "PersistenceSavePre",
    callback = function()
        require("neo-tree.command").execute({ action = "close" })
        require("cmake-tools").close_executor()
    end,
})

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
                path = vim.fn.stdpath("state") .. "/sessions/workspaces",
                auto_open = false,
                notify_info = false,
                hooks = {
                    add = {},
                    remove = {},
                    rename = {},
                    open_pre = {},
                    open = function()
                        require("persistence").load()
                        require("persistence").start()
                    end,
                },
            })
            require("telescope").load_extension("workspaces")
        end,
    },
    {
        "folke/snacks.nvim",
        optional = true,
        opts = function(_, opts)
            table.insert(opts.dashboard.preset.keys, 3, {
                action = ListProjects,
                desc = "Projects",
                icon = " ",
                key = "p",
            })
        end,
    },
}
