return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts = opts or {}

      ------------------------------------------------------------------------
      -- 1. Dashboard header (your ASCII art)
      ------------------------------------------------------------------------
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.header = [[

  _   _                       _____                 _     
 | \ | |                     / ____|               | |    
 |  \| | ___ _   _ _ __ ___ | |  __ _ __ __ _ _ __ | |__  
 | . ` |/ _ \ | | | '__/ _ \| | |_ | '__/ _` | '_ \| '_ \ 
 | |\  |  __/ |_| | | | (_) | |__| | | | (_| | |_) | | | |
 |_| \_|\___|\__,_|_|  \___/ \_____|_|  \__,_| .__/|_| |_|
                                             | |          
                                             |_|          

      ]]

      ------------------------------------------------------------------------
      -- 2. Explorer width (Snacks.explorer sidebar)
      ------------------------------------------------------------------------
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = opts.picker.sources.explorer or {}

      -- Merge with any existing layout config
      opts.picker.sources.explorer.layout = vim.tbl_deep_extend(
        "force",
        opts.picker.sources.explorer.layout or {},
        {
          preset = "sidebar",       -- keep sidebar layout
          layout = {
            width = 30,             -- <<< change this number to your taste
          },
        }
      )

      return opts
    end,
  },
}
