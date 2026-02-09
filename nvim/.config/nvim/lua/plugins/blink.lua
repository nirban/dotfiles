return {
  {
    "saghen/blink.cmp",
    optional = true, -- only if blink is actually installed (LazyVim default now)
    opts = {
      completion = {
        list = {
          selection = {
            -- ⬇⬇⬇ the important bit
            preselect = false,      -- do NOT select the first item automatically
            -- optional: also stop auto-inserting text when you move in the list
            -- auto_insert = false,
          },
        },
      },
    },
  },
}
