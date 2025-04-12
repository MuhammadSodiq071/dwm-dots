return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua    = { "stylua" },
      c      = { "clang-format" },
      go     = { "gofumpt" },
      python = { "black" },
    },
  },
}
