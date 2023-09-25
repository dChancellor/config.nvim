-- Set highlight on search
vim.o.hlsearch = false
-- Make line numbers default
vim.wo.number = true
-- Enable mouse mode
vim.o.mouse = 'a'
--  Shares clipboard
vim.o.clipboard = 'unnamedplus'
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Gui colors
vim.o.termguicolors = true
-- Prevents line wrapping
vim.o.wrap = false
-- Relative Line numbers
vim.o.relativenumber = true
-- Prevent auto commenting next line
vim.cmd([[autocmd FileType * set formatoptions-=cro]])
-- Removes bottom command line bar
vim.cmd([[set cmdheight=0]])
-- Popup blend
vim.opt.pumblend = 10
-- Maximum items in popup
vim.opt.pumblend = 10
-- Status line takes care of this
vim.opt.showmode = false
-- Show sign column
vim.opt.signcolumn = 'yes'
-- Smart indenting
vim.opt.smartindent = true

vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
})
-- Doesn't create swap files
vim.opt.swapfile = false
-- Makes status line span entire window
vim.opt.laststatus = 3
