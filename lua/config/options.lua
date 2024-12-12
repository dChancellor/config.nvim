-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers show
vim.wo.number = true
vim.o.relativenumber = true

-- Set <space> as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set p to paste whats in clipboard
vim.opt.clipboard = 'unnamedplus'

-- Remove command line bar when not in use
--vim.opt.cmdheight = 0

-- Remove tilde characters in left bar
vim.opt.fillchars = { eob = " " }
