-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers show
vim.o.relativenumber = true
vim.opt.number = true

-- Set <space> as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set p to paste whats in clipboard
vim.opt.clipboard = 'unnamedplus'

-- Remove command line bar when not in use
vim.opt.cmdheight = 0

-- Remove tilde characters in left bar
vim.opt.fillchars = { eob = " " }

-- Use UTF-8
vim.o.encoding = "utf-8"
vim.opt.fileencoding = 'utf-8'
vim.scriptencoding = 'utf-8'

-- Enable gui color display
vim.o.termguicolors = true

-- Indents next line to same indent as current line when hitting <Enter>
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Removes backing up files before overwriting
vim.opt.backup = false

-- Set the number of lines to scroll when the cursor is moved vertically
vim.opt.scrolloff = 10

-- Shows the preview of the command result
vim.opt.inccommand = 'split'

-- Set search results to be case insensitive
vim.opt.ignorecase = true

-- Prevent line wrapping
vim.opt.wrap = false
