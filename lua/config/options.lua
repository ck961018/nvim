-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if LazyVim.is_win() then
    LazyVim.terminal.setup("pwsh")
end

vim.g.autoformat = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep around the cursor.
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.cindent = true
vim.opt.cino = "N-s, g0"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.showmatch = true
vim.opt.wildmenu = true
vim.opt.termguicolors = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.exrc = true
vim.opt.wrap = false

vim.opt.autoread = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.g.completeopt = "menu, menuone, noselect, noinsert"
vim.opt.pumheight = 10

vim.opt.shortmess = vim.opt.shortmess + "c"

vim.opt.fileencoding = "utf-8"

-- vim.o.jumpoptions = "stack"

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
