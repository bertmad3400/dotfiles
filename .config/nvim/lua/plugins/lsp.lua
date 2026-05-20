return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        jinja_lsp = {
          filetypes = { "jinja", "html" },
        },
      },
    },
  },
}
