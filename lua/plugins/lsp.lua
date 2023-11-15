return {
    "neovim/nvim-lspconfig",
    cmd = { "Mason", "Neoconf" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
        },
        "nvimdev/lspsaga.nvim",
        {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        }
    },
    config = function()
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
            clangd = {
                filetypes = { "c", "cpp", "objc", "objcpp", "h" },
                cmd = {
                    "clangd",
                    "--header-insertion=never",
                    "--clang-tidy",
                    "--clang-tidy-checks=performance-*,bugprone-*",
                    "--background-index",
                    "--all-scopes-completion",
                    "--completion-style=detailed",
                },
                on_new_config = function(new_config, _)
                    local status, cmake = pcall(require, "cmake-tools")
                    if status then
                        cmake.clangd_on_new_config(new_config)
                    end
                end,
            },
            neocmake = {},
        }
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true })
            end

            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap("gd", require "telescope.builtin".lsp_definitions, "[G]oto [D]efinition")
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            nmap("gi", require "telescope.builtin".lsp_implementations, "[G]oto [I]mplementation")

            nmap("<c-k>", vim.lsp.buf.signature_help, "Signature Documentation")
            nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
            nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
            nmap("<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders))
            end, "[W]orkspace [L]ist Folders")

            nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
            nmap("<leader>lf", "<cmd>Lspsaga finder<CR>", "Lspsaga Finder")
            nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
            nmap("<leader>rn", "<cmd>Lspsaga rename ++project<cr>", "[R]e[n]ame")
            nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
            --nmap("<leader>da", require "telescope.builtin".diagnostics, "[D]i[A]gnostics")
            nmap("<leader>da", "<cmd>lua vim.diagnostic.open_float()<cr>", "[D]i[A]gnostics")
            nmap("<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<cr>", "[D]iagnostics [N]ext")
            nmap("<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[D]iagnostics [P]revious")
            nmap("<space>f", function()
                vim.lsp.buf.format { async = true }
            end, "[F]ormat code")
        end
        require("neoconf").setup()
        require("neodev").setup()
        require("fidget").setup()
        require("lspsaga").setup({
            finder = {
                keys = {
                    quit = "<leader>q",
                    toggle_or_open = "<cr>",
                    tabnew = "n",
                },
            },
        })
        require("mason").setup({
            ensure_installed = { "cmakelang", "cmakelint" }
        })
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
        })

        for server, config in pairs(servers) do
            require("lspconfig")[server].setup(
                vim.tbl_deep_extend("keep",
                    {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    },
                    config
                )
            )
        end
    end,
}
