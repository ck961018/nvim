local option          = vim.opt
--local buffer          = vim.b
--local global          = vim.g

option.tabstop        = 4
option.softtabstop    = 4
option.shiftwidth     = 4
option.expandtab      = true
option.smartindent    = true
option.shiftround     = true
option.autoindent     = true
option.smarttab       = true

option.smartcase      = true
option.number         = true
option.relativenumber = true
option.showmode       = false
option.wildmenu       = true
option.cursorline     = true
option.termguicolors  = true
option.autoread       = true
option.updatetime     = 50
option.undofile       = true
option.splitright     = true
option.splitbelow     = true
option.hidden         = true
option.wrap           = false
option.title          = true
option.swapfile       = false
option.exrc           = true
option.signcolumn     = "yes"

option.clipboard:append("unnamedplus")

option.fileencoding = "utf-8"
