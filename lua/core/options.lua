if vim.fn.has("wsl") == 1 then
    System = "wsl"
elseif vim.fn.has("win32") == 1 then
    System = "windows"
end

IgnoredFiletypes      = {
    "qf",
    "lazy",
    "help",
    "alpha",
    "Neogit*",
    "Outline",
    "NvimTree",
    "translator",
    "toggleterm",
    "sagafinder",
    "DiffviewFiles",
    "spectre_panel",
    "translatorborder",
    "camek_tools_terminal",
}

local option          = vim.opt
local global          = vim.g
-- local buffer          = vim.b

option.tabstop        = 4
option.softtabstop    = 4
option.shiftwidth     = 4
option.expandtab      = true
option.shiftround     = true
option.smartindent    = true
option.autoindent     = true
option.smarttab       = true
option.cindent        = true
option.cino           = "N-s, g0"

option.ignorecase     = true
option.smartcase      = true

option.hlsearch       = true
option.incsearch      = true

option.number         = true
option.relativenumber = true
option.showmode       = false
option.showmatch      = true
option.wildmenu       = true
option.cursorline     = true
option.termguicolors  = true
option.autoread       = true
option.updatetime     = 50
option.undofile       = true
option.splitright     = true
option.splitbelow     = true
option.hidden         = true
option.title          = true
option.swapfile       = false
option.exrc           = true
option.signcolumn     = "yes"

option.wrap           = false

-- option.termencoding   = "utf-8"
option.fileencodings  = { "ucs-bom", "utf-8", "cp936" }

--neovide
if global.neovide then
    global.neovide_scale_factor = 0.8
end
