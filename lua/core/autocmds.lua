vim.api.nvim_create_autocmd({ "DirChanged" }, {
    pattern = "global",
    callback = function()
        local nvim_lua_path = vim.fn.expand('%:p:h') .. '/.nvim.lua'
        if vim.fn.filereadable(nvim_lua_path) == 1 then
            vim.cmd.so(".nvim.lua")
            vim.print(".nvim.lua is loaded")
        end
    end,
})

-- Apply and restore local patches on plugin update/install
-- Credit: @Bekaboo in Bekaboo/nvim
vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyInstall*", "LazyUpdate*" },
  group = vim.api.nvim_create_augroup("LazyPatches", { clear = true }),
  desc = "Reverse/apply local patches on updating/installing plugins",
  callback = function(info)
    local patches_path = vim.fn.stdpath("config") .. "/patches"
    print(patches_path)
    for patch in vim.fs.dir(patches_path) do
      local patch_path = patches_path .. "/" .. patch
      local plugin_path = vim.fn.stdpath("data") .. "/lazy/" .. (patch:gsub("%.patch$", ""))


      local gitcmd = function(path, cmd)
        local shell_args = { "git", "-C", path, unpack(cmd) }
        local shell_out = vim.fn.system(shell_args)
        return {
          success = (vim.v.shell_error == 0),
          output = shell_out,
        }
      end


      if vim.fn.filereadable(patch_path) then
        if info.match:match("Pre$") and gitcmd(plugin_path, { "diff", "--stat" }).output ~= "" then
          vim.notify("reverting plugin patch" .. patch_path)
          gitcmd(plugin_path, { "apply", "--reverse", "--ignore-space-change", patch_path })
        else
          vim.notify("applying plugin patch" .. patch_path)
          gitcmd(plugin_path, { "apply", "--ignore-space-change", patch_path })
        end
      end
    end
  end,
})
