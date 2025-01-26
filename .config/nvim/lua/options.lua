local api = vim.api
local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

opt.termguicolors = true
o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true -- tabs = spaces
o.shiftwidth = 2 -- 2 spaces with < >
o.smartindent = true
o.tabstop = 2 -- tabs = 2 spaces
o.softtabstop = 2 -- 2 spaces with <Tab>

-- api.nvim_create_autocmd("FileType", {
--   pattern = "c",
--   callback = function ()
--     opt.tabstop = 4
--     opt.shiftwidth = 4
--     opt.softtabstop = 4
--   end,
-- })

opt.fillchars = { eob = " " } -- do not show ~ in empty lines
o.ignorecase = true
o.smartcase = true
-- o.mouse = "" -- disable mouse supporting (a for enable)

-- Line
opt.number = true
opt.relativenumber = true
o.numberwidth = 3
o.ruler = false
api.nvim_set_hl(0, "CursorLineNr", { fg = "#f2d61b", bold = true })

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
--opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- others
opt.showmatch = true
opt.scrolloff = 1

