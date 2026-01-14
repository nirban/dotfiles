-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })

vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = "Copilot Accept",
})
