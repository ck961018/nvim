return {
    "neovim/nvim-lspconfig",
    cmd = { "Mason", "Neoconf" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        "nvimdev/lspsaga.nvim",
        {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
    config = function()
        local clangd = "clangd"
        local clang = "clang"
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
                    clangd,
                    "--query-driver=" .. clang,
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
            omnisharp_mono = {},
            rust_analyzer = {}
        }
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true })
            end

            nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

            -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

            nmap("K", [[<cmd>Lspsaga hover_doc<CR>]], "Hover Documentation")
            nmap("<leader>fr", [[<cmd>Lspsaga finder<CR>]], "Lspsaga [F]inde[r]")
            nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
            nmap("<leader>rn", [[<cmd>Lspsaga rename ++project<CR>]], "[R]e[n]ame")
            nmap("<leader>ca", [[<cmd>Lspsaga code_action<CR>]], "[C]ode [A]ction")
            --nmap("<leader>da", require "telescope.builtin".diagnostics, "[D]i[A]gnostics")
            nmap("<leader>da", [[<cmd>lua vim.diagnostic.open_float()<CR>]], "[D]i[A]gnostics")
            nmap("<leader>dn", [[<cmd>lua vim.diagnostic.goto_next()<CR>]], "[D]iagnostics [N]ext")
            nmap("<leader>dp", [[<cmd>lua vim.diagnostic.goto_prev()<CR>]], "[D]iagnostics [P]revious")
            nmap("<space>f", function()
                vim.lsp.buf.format { async = true }
            end, "[F]ormat code")
        end
        require("neoconf").setup()
        require("neodev").setup()
        require("lspsaga").setup({
            finder = {
                keys = {
                    quit = "<ESC>",
                    toggle_or_open = "<CR>",
                    tabnew = "n",
                },
            },
        })
        require("mason").setup()
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
