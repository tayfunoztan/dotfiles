local icons = require('globals').icons

vim.opt.autowrite = true -- Enable auto write

-- indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically

-- show whitespace
vim.opt.list = false -- Show some invisible characters (tabs...
vim.opt.listchars = { space = '⋅', trail = '⋅', tab = '  ↦' }

-- show line number
vim.opt.number = true -- show line number
vim.opt.relativenumber = true

vim.o.winborder = 'rounded' -- use rounded borders for floating windows.

vim.opt.mouse = 'a' -- enable mouse mode

vim.opt.linebreak = true -- wrap lines at convenient points

-- folding
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.wo.foldtext = ''
-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo[0][0].foldmethod = 'expr'

-- UI characters
vim.opt.fillchars = {
    foldopen = icons.arrows.down,
    foldclose = icons.arrows.right,
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
}

vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.clipboard = 'unnamedplus' -- sync with system clipboard

vim.o.undofile = true -- save undo history.

vim.opt.signcolumn = 'yes' -- always show the signcolumn, otherwise it would shift the text each time
-- vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

-- case insensitive searching UNLESS /C or the search has capitals
vim.opt.ignorecase = true -- ignore case
vim.opt.smartcase = true -- don't ignore case with capitals

vim.opt.cursorline = true -- enable highlighting of the current line

vim.opt.splitbelow = true -- put new windows below current
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true -- put new windows right of current

-- completion
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.pumheight = 10 -- maximum number of entries in a popup

vim.opt.shortmess:append { W = true, I = true, c = true, C = true }

-- status line
vim.o.laststatus = 3 -- global statusline

-- Update times and timeouts.
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- lower than default (1000) to quickly trigger which-key

vim.opt.shortmess:append { W = true, I = true, c = true, C = true }

vim.opt.scrolloff = 4 -- Lines of context
