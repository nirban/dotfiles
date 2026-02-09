return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       transparent_background = false,
  --       integrations = {
  --         bufferline = true,
  --         treesitter = true,
  --         telescope = true,
  --         cmp = true,
  --       },
  --     })
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  --
  -- {
  --   "folke/tokyonight.nvim",
  --   -- lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("tokyonight")
  --   end,
  -- },

    {
        "rockyzhang24/arctic.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        name = "arctic",
        branch = "main",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd("colorscheme arctic")
        end
    },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "arctic",
        },
    },
}
