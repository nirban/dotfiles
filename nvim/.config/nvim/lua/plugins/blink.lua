return 
{
    {
        "saghen/blink.cmp",
        optional = true,

        opts = function(_, opts)
        opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, 
            {
                list = {
                    selection = {
                        preselect = false,
                    -- auto_insert = false,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 80,
                },
            })
        end,
    },
}

