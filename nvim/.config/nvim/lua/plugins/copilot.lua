-- Github Copilot
return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
      --
      -- Enable/disable per filetype (tweak to taste)
      vim.g.copilot_filetypes = {
        ["*"] = true,
        TelescopePrompt = false,
        ["neo-tree"] = false,
        ["snacks_picker"] = false,
        ["dap-repl"] = false,
        markdown = true,
        gitcommit = true,
      }

      -- Insert-mode keymaps (expr mappings that call Copilot's functions)
      -- Accept suggestion (Ctrl-Y)
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
        desc = "Copilot Accept",
      })

      -- Cycle suggestions
      vim.keymap.set("i", "<M-]>", "copilot#Next()", {
        expr = true,
        silent = true,
        desc = "Copilot Next",
      })
      vim.keymap.set("i", "<M-[>", "copilot#Previous()", {
        expr = true,
        silent = true,
        desc = "Copilot Previous",
      })

      -- Dismiss current suggestion
      vim.keymap.set("i", "<C-]>", "copilot#Dismiss()", {
        expr = true,
        silent = true,
        desc = "Copilot Dismiss",
      })
    end,
  },
}
