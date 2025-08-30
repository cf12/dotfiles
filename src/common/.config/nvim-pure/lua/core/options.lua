vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.o.relativenumber = true

-- vim.o.clipboard = "unnamedplus"

vim.o.mouse = "a"
vim.o.showmode = false

vim.o.wrap = false

vim.o.breakindent = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.undofile = true

-- Case insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

-- Performance tweaks
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.o.confirm = true
