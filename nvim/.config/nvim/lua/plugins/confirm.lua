return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = { 
      c = { "clang_format" }, 
      cpp = { "clang_format" },
    },
    formatters = {
      clang_format = {
        prepend_args = {
          "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
        },
      },
    },
    -- Completely disable automatic formatting on save
    format_on_save = false,
  },
}