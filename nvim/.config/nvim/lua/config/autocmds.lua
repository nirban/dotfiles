-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- Auto-open neo-tree on startup if no file is passed

-- vim.lsp.enable
---vim.api.nvim_del_augroup_by_name("lazyvim_format_on_save")
---
-- Auto-open Snacks explorer when starting `nvim` with no file arguments
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- don't auto-open if nvim was started with a file or directory (e.g. `nvim somefile`)
    if vim.fn.argc() ~= 0 then
      return
    end

    -- Snacks.explorer is what LazyVim uses for <leader>e by default :contentReference[oaicite:2]{index=2}
    if _G.Snacks and Snacks.explorer then
      Snacks.explorer()
    else
      -- fallback if the global isn't there for some reason
      pcall(function()
        require("snacks").explorer()
      end)
    end

    -- After explorer opens, resize the left-most window
    vim.schedule(function()
      -- Go to left-most window (where Explorer usually is)
      vim.cmd("wincmd h")
      -- Set the width you like (try 30–40 and tweak)
      vim.cmd("vertical resize 35")
    end)


  end,
})
