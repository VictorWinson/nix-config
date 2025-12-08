-- basic editing behaviour
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.termguicolors = true
opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 250
opt.signcolumn = 'yes'
opt.scrolloff = 5

-- keymaps
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit window' })
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save buffer' })
