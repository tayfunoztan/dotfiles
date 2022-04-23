local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end
local neo_tree = { sections = { lualine_a = { get_short_cwd } }, filetypes = { "neo-tree" } }

require("lualine").setup({
  options = {
    theme = "gruvbox",
    icons_enabled = true,
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 2, right = 0 } },
      { "filename", path = 1, symbols = { modified = " [+] ", readonly = " [-] " } },
    },
    lualine_x = {
      {
        "branch",
        icon = "",
      },
      "diff",
    },
    lualine_y = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 2, right = 0 } },
      { "filename", path = 1, symbols = { modified = " [+] ", readonly = " [-] " } },
    },
    lualine_x = {
      {
        "branch",
        icon = "",
      },
      "diff",
    },
    lualine_y = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", neo_tree },
})
