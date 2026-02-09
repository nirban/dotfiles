-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Set tab = 4 spaces
vim.o.tabstop = 4 -- number of visual spaces per TAB
vim.o.shiftwidth = 4 -- spaces used for autoindent
vim.o.expandtab = true -- convert tabs to spaces
vim.o.softtabstop = 4 -- spaces when hitting <Tab>

-- Disable format on save
vim.g.autoformat = false

-- Absolute line numbers only
vim.opt.number = true
vim.opt.relativenumber = false

-- Colorscheme  
-- vim.cmd.Colorscheme("arctic")
-- vim.cmd.Colorscheme = "arctic"
