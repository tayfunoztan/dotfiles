------------------------------------------------------------------------------
-- nvim-lspconfig
------------------------------------------------------------------------------

-- Mappings.
local opts = { noremap=true, silent=true }

-- Diagnostic settings
vim.diagnostic.config {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
}

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], opts)

  -- vim.cmd [[
  --   command! Format execute 'lua vim.lsp.buf.formatting()'
  -- ]]
  --

  -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
  -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

local handlers = {
  ['textDocument/hover'] = function(...)
    local buf = vim.lsp.handlers.hover(...)
    if buf then
      vim.api.nvim_buf_set_keymap(buf, 'n', 'K', '<Cmd>wincmd p<CR>', { noremap = true, silent = true })
    end
  end
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	'pyright',
	'rust_analyzer',
	'tsserver',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
    init_options = {
      usePlaceholders=true,
      completeUnimported=true,
    }
}



------------------------------------------------------------------------------
-- nvim-cmp | vim-vsnip
-- ----------------------------------------------------------------------------
vim.o.completeopt = 'menu,menuone,noselect'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({
	    select = true,
    }), 
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  preselect = cmp.PreselectMode.None,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }),
}


------------------------------------------------------------------------------
-- telescope.nvim
-- ----------------------------------------------------------------------------
local actions = require "telescope.actions"
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
	["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,
      },
      n = {
	["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,
      }
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}
require('telescope').load_extension 'fzf'

vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers({sort_lastused = true})<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })


------------------------------------------------------------------------------
-- nvim-tree.lua
------------------------------------------------------------------------------
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 0,
        folder_arrows = 0
}
vim.g.nvim_tree_group_empty = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    "packer",
    "qf",
    "Trouble"
  }
}

vim.g.nvim_tree_icons = {
	default = '',
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = " ",
		renamed = "➜",
		untracked = "★"
	},
	folder = {
		default = "▶",
		open = "▼"
	}
}

vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', {
	noremap = true,
	silent = true
})

vim.api.nvim_set_keymap('n', '<leader>m', ':NvimTreeFindFile<CR>', {
	noremap = true,
	silent = true
})

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- following options are the default
require'nvim-tree'.setup {
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close          = false,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir   = {
    -- enable the feature
    enable = true,
    -- allow to open the tree if it was previously closed
    auto_open = true,
  },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when you run `:cd` usually)
  update_cwd         = false,
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    icons = {
      hint = " ",
      info = " ",
      warning = " ",
      error = "E",
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- Hide the root path of the current folder on top of the tree 
    hide_root_folder = false,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
      list = {
	  { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
	  { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
	  { key = "<C-v>",                        cb = tree_cb("vsplit") },
	  { key = "<C-s>",                        cb = tree_cb("split") },
	  { key = "<C-t>",                        cb = tree_cb("tabnew") },
	  { key = "<",                            cb = tree_cb("prev_sibling") },
	  { key = ">",                            cb = tree_cb("next_sibling") },
	  { key = "P",                            cb = tree_cb("parent_node") },
	  { key = "<BS>",                         cb = tree_cb("close_node") },
	  { key = "<S-CR>",                       cb = tree_cb("close_node") },
	  { key = "<Tab>",                        cb = tree_cb("preview") },
	  { key = "K",                            cb = tree_cb("first_sibling") },
	  { key = "J",                            cb = tree_cb("last_sibling") },
	  { key = "I",                            cb = tree_cb("toggle_ignored") },
	  { key = "H",                            cb = tree_cb("toggle_dotfiles") },
	  { key = "R",                            cb = tree_cb("refresh") },
	  { key = "a",                            cb = tree_cb("create") },
	  { key = "d",                            cb = tree_cb("remove") },
	  { key = "r",                            cb = tree_cb("rename") },
	  { key = "<C-r>",                        cb = tree_cb("full_rename") },
	  { key = "x",                            cb = tree_cb("cut") },
	  { key = "c",                            cb = tree_cb("copy") },
	  { key = "p",                            cb = tree_cb("paste") },
	  { key = "y",                            cb = tree_cb("copy_name") },
	  { key = "Y",                            cb = tree_cb("copy_path") },
	  { key = "gy",                           cb = tree_cb("copy_absolute_path") },
	  { key = "[c",                           cb = tree_cb("prev_git_item") },
	  { key = "]c",                           cb = tree_cb("next_git_item") },
	  { key = "_",                            cb = tree_cb("dir_up") },
	  { key = "S",                            cb = tree_cb("system_open") },
	  { key = "q",                            cb = tree_cb("close") },
	  { key = "g?",                           cb = tree_cb("toggle_help") },
      }
    }
  }
}
 

------------------------------------------------------------------------------
-- gitsigns.nvim
------------------------------------------------------------------------------
require('gitsigns').setup {
  keymaps = {
     -- Default keymap options
     noremap = true,
     buffer = true,

     ['n ]c'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
     ['n [c'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

     ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
     ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
     ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
     ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

     -- Text objects
     ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
     ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
   },
}

------------------------------------------------------------------------------
-- diffview.nvim
------------------------------------------------------------------------------
require'diffview'.setup {
  use_icons = false,         -- Requires nvim-web-devicons
    icons = {                 -- Only applies when use_icons is true.
    folder_closed = "▶",
    folder_open = "▼",
  },
  signs = {
    fold_closed = "▶",
    fold_open = "▼",
  },
}

------------------------------------------------------------------------------
-- lualine.nvim
------------------------------------------------------------------------------
require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'powerline',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename', 'lsp_progress'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {},
  extensions = {"quickfix", "nvim-tree"}
}

------------------------------------------------------------------------------
-- rust-tools.nvim
------------------------------------------------------------------------------
require('rust-tools').setup({})
