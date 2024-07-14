local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "autopep8" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    java = { "astyle" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = false,
  },
}

require("conform").setup(options)
