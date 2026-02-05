return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local util = require("lspconfig.util")

      -- Register a custom "prolog" server config if it doesn't exist yet
      if not configs.prolog then
        configs.prolog = {
          default_config = {
            cmd = {
              "swipl",
              "-g", "use_module(library(lsp_server)).",
              "-g", "lsp_server:main",
              "-t", "halt",
              "--", "stdio",
            },
            filetypes = { "prolog" },
            root_dir = util.root_pattern("pack.pl", ".git"),
            single_file_support = true,
          },
          docs = {
            description = "SWI-Prolog LSP (lsp_server pack)",
          },
        }
      end

      -- Make LazyVim actually enable this server
      opts.servers = opts.servers or {}
      opts.servers.prolog = opts.servers.prolog or {}

      -- Use the normal lspconfig setup
      local old_setup = opts.setup or {}
      opts.setup = old_setup
      opts.setup.prolog = function(_, server_opts)
        lspconfig.prolog.setup(server_opts)
        return true
      end

      return opts
    end,
  },
}

