" vim: set foldmethod=marker foldlevel=0 nomodeline:

let g:python3_host_prog = '/usr/local/bin/python3'

" ============================================================================
" VIM-PLUG {{{
" ============================================================================
let g:plug_shallow = 0
let g:plug_window = '-tabnew'
let g:plug_pwindow = 'vertical rightbelow new'

call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'tayfunoztan/ReplaceWithRegister'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 't9md/vim-choosewin'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'gruvbox-community/gruvbox'
  let g:gruvbox_contrast_dark='hard'

call plug#end()

" }}}
" ============================================================================
" OPTIONS {{{
" ============================================================================

" Make line numbers default
set number

" Incremental live completion (note: this is now a default on master)
set inccommand=nosplit

" Set highlight on search
set hlsearch

" Do not save when switching buffers
set hidden

" Enable mouse mode
set mouse=a

" Enable break indent
set breakindent

" Save undo history
set undofile

" Case insensitive searching UNLESS /C or capital in search
set ignorecase
set smartcase

" Decrease update time
set updatetime=300

set signcolumn=yes

" Set completeopt
set completeopt=menuone,noinsert

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme gruvbox

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

let mapleader= ','

imap jj <Esc>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

" }}}
" ============================================================================
" PLUGINS {{{{{{
" ============================================================================
lua require('init')

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_echo_go_info = 0

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1
let g:go_gopls_complete_unimported=1

let g:go_doc_keywordprg_enabled = 0

let g:go_test_show_name = 0
let g:go_list_type = "quickfix"

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1

let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }
 
" ----------------------------------------------------------------------------
" vim-choosewin
" ----------------------------------------------------------------------------
nmap  -  <Plug>(choosewin)
let g:choosewin_label_padding      = 5
let g:choosewin_blink_on_land      = 0 " don't blink at land
let g:choosewin_statusline_replace = 1 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline

" }}}}}}
