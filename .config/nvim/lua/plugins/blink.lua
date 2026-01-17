return {
  {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",
    event = "InsertEnter",
    opts = {
      keymap = {
        ["<CR>"] = { "accept", "fallback" },
        ["<C-\\>"] = { "hide", "fallback" },
        ["<C-n>"] = { "select_next", "show" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<C-p>"] = { "select_prev" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        list = {
          -- Insert items while navigating the completion list.
          selection = { preselect = true, auto_insert = true },
          max_items = 10,
        },
        documentation = { auto_show = true },
        menu = {
          scrollbar = false,
          draw = {
            gap = 2,
            columns = {
              { "kind_icon", "kind", gap = 1 },
              { "label", "label_description", gap = 1 },
            },
          },
        },
      },
      snippets = { preset = "luasnip" },
      cmdline = { enabled = false },
      sources = {
        default = {
          "lsp",
          "buffer",
          "snippets",
          "path",
        },
      },
      appearance = {
        kind_icons = require("globals").icons.symbol_kinds,
      },
    },
  },
}
