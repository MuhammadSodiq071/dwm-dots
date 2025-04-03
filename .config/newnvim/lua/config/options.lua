vim.g.mapleader = ' '
-- vim.g.maplocalleader = '\\'

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false -- Disable swap file
vim.opt.backup = false -- Disable backup file

vim.opt.wrap = false -- Disable line wrapping
vim.opt.smoothscroll = true -- Enable smooth scrolling
vim.opt.scrolloff = 1 -- Minimum number of screen lines to keep above and below the cursor

-- vim.opt.mouse = '' -- Disable mouse support

vim.opt.splitright = true -- Split vertical window to the right
vim.opt.splitbelow = true

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.cindent = true -- Enable C-style indentation
vim.opt.smarttab = true -- Insert appropriate number of spaces on tab
vim.opt.smartindent = true -- Smart autoindenting on new lines
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for

vim.opt.hlsearch = false -- Disable highlight on search
vim.opt.incsearch = true -- Show search matches as you type

vim.opttermguicolors = true -- Enable true color support
-- vim.opt.colorcolumn = '130' -- Highlight column 130
vim.opt.cursorline = true -- Highlight the current line

vim.opt.updatetime = 50 -- Faster completion (default is 4000ms)
vim.opt.undofile = true

-- For obsidian.nvim
vim.opt.cole = 2

