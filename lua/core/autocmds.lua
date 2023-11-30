-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = "*",
--     callback = function()
--         vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
--     end,
-- })

if vim.g.neovide then
    local function set_ime(args)
        if args.event:match("Enter$") then
            vim.g.neovide_input_ime = true
        else
            vim.g.neovide_input_ime = false
        end
    end

    local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
        group = ime_input,
        pattern = "*",
        callback = set_ime
    })

    vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
        group = ime_input,
        pattern = "*"--[[ "[/\\?]" ]],
        callback = set_ime
    })
end
