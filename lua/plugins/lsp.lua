if vim.lsp ~= nil and vim.lsp.inlay_hint ~= nil then
    vim.lsp.inlay_hint.enable = false
end

return {
    {
        "neovim/nvim-lspconfig",
        event = "LazyFile",
        opts = {
            setup = {
                rust_analyzer = function()
                    return true
                end,
            },
            servers = {
                clangd = {
                    keys = {
                        { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=never",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                    },
                    filetypes = { "c", "cpp", "objc", "objcpp", "h" },
                    on_new_config = function(new_config, _)
                        local status, cmake = pcall(require, "cmake-tools")
                        if status then
                            cmake.clangd_on_new_config(new_config)
                        end
                    end,
                },
            },
        },
    },
}
