require'lualine'.setup {
  options = {
    icons_enabled = true,
    -- theme = 'gruvbox',
    -- theme = 'seoul256',
    theme = 'tokyonight',
    -- theme = 'powerline',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
	    { 'filename', path = 1, symbols = { modified = ' [+] ', readonly = ' [-] ' } },
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
	    { 'filename', path = 1, symbols = { modified = ' [+] ', readonly = ' [-] ' } },
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {"quickfix", "nvim-tree"}
}
