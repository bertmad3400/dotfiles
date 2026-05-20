local opts = function()
  local icons = vim.deepcopy(LazyVim.config.icons.kinds)

  -- HACK: fix lua's weird choice for `Package` for control
  -- structures like if/else/for/etc.
  icons.lua = { Package = icons.Control }

  ---@type table<string, string[]>|false
  local filter_kind = false
  if LazyVim.config.kind_filter then
    filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
    filter_kind._ = filter_kind.default
    filter_kind.default = nil
  end

  local opts = {
    attach_mode = "global",
    backends = { "lsp", "treesitter", "markdown", "man" },
    icons = icons,
    filter_kind = filter_kind,
    layout = {
      max_width = { 80, 0.8 },
      width = nil,
      min_width = 40,
      resize_to_content = true,
    },
    float = {
      max_height = 0.8,
      border = "rounded",
      win_options = {
        winblend = 10, -- transparency
      },
    },
    highlight_mode = "split_width",
    nav = {
      border = "rounded",
      max_height = 0.9,
      min_height = { 60, 0.6 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = {
        cursorline = true,
        winblend = 10,
      },
      -- Jump to symbol in source window when the cursor moves
      autojump = false,
      -- Show a preview of the code in the right column, when there are no child symbols
      preview = true,
      -- Keymaps in the nav window
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["h"] = "actions.left",
        ["l"] = "actions.right",
        ["<C-c>"] = "actions.close",
      },
    },
  }
  return opts
end

return {
  "stevearc/aerial.nvim",
  opts = opts(),
  keys = {
    { "<leader>css", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    { "<leader>csn", "<cmd>AerialNavToggle<cr>", desc = "Aerial Nav (Symbols)" },
    { "<leader>cn", "<cmd>AerialNext<cr>", desc = "Next symbol (Aerial )" },
    { "<leader>cN", "<cmd>AerialPrev<cr>", desc = "Next symbol (Aerial )" },
  },
}
