return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<c-\>]], -- Ctrl+\ toggles the terminal
      shade_terminals = true,
      direction = "horizontal", -- "horizontal", "vertical", "float", "tab"
      start_in_insert = true,
      persist_size = true,
      persist_mode = false,
    })
  end,
}
