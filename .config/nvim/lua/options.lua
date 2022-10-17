local o, opt, fn = vim.o, vim.opt, vim.fn

o.background = "dark"

o.updatetime = 300
o.timeout = true
o.timeoutlen = 500
o.ttimeoutlen = 10

o.splitbelow = true
o.splitright = true
opt.fillchars = {
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

o.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

o.wildmode = "longest:full,full" -- Shows a menu bar as opposed to an enormous list
o.wildignorecase = true -- Ignore case when completing file names and directories
o.pumblend = 10 -- Make popup window translucent

o.number = true
-- o.conceallevel = 3
o.linebreak = true -- lines wrap at words rather than random characters
o.signcolumn = "yes"
o.cmdheight = 1
o.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '

o.list = true -- invisible chars
opt.listchars = {
  eol = nil,
  tab = "  ", -- Alternatives: '▷▷',
  extends = "›", -- Alternatives: … »
  precedes = "‹", -- Alternatives: … «
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

o.wrap = false
o.autoindent = true
o.shiftround = true
o.expandtab = true
o.shiftwidth = 2

vim.opt.pumheight = 15 -- Maximum number of entries in a popup
o.confirm = true -- make vim prompt me to save before doing destructive things
opt.completeopt = { "menuone", "noselect" }
o.autowrite = true
opt.clipboard = { "unnamedplus" }
o.laststatus = 3
o.termguicolors = true

o.showmode = false
opt.sessionoptions = {
  "globals",
  "buffers",
  "curdir",
  "winpos",
  "tabpages",
}

o.ignorecase = true
o.smartcase = true
o.scrolloff = 9
o.sidescrolloff = 10
