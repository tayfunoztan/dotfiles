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
Plug 'junegunn/vim-peekaboo'

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'christoomey/vim-tmux-navigator'
Plug 'tayfunoztan/ReplaceWithRegister'
Plug 'Raimondi/delimitMate'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'simrat39/rust-tools.nvim'
Plug 'othree/yajs.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 't9md/vim-choosewin'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
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
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr

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

set pumheight=15

set autoread

set clipboard=unnamed

" Split vertical windows right to the current windows
set splitright

" Split horizontal windows below to the current windows
set splitbelow

set scrolloff=5

" Makes backspace key more powerful.
set backspace=indent,eol,start

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

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" Do not show stupid q: window
map q: :q

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
nnoremap <leader>c :cclose<bar>lclose<cr>

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
augroup vimrc
  autocmd!
augroup END

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

augroup Terminal
  autocmd!
  au TermOpen * set nonu
augroup end


augroup vimrc

  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  " cursorline only active window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

augroup END

" }}}
" ============================================================================
" PLUGINS {{{{{{
" ============================================================================
lua require('init')

" ----------------------------------------------------------------------------
" fzf - fzf.vim
" ----------------------------------------------------------------------------
let g:fzf_command_prefix = 'Fzf'

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_echo_go_info = 0
let go_gopls_enabled = 0
let go_doc_keywordprg_enabled = 0

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1
let g:go_gopls_complete_unimported=1

let g:go_doc_keywordprg_enabled = 0

let g:go_test_show_name = 0
let g:go_list_type = "quickfix"

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1


let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

" ----------------------------------------------------------------------------
" delimitMate 
" ----------------------------------------------------------------------------
let g:delimitMate_expand_cr = 1   
let g:delimitMate_expand_space = 1    
let g:delimitMate_smart_quotes = 1    
let g:delimitMate_expand_inside_quotes = 1    
" let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'   
" let g:delimitMate_quotes = "\" '"

" ----------------------------------------------------------------------------
" vim-choosewin
" ----------------------------------------------------------------------------
nmap  -  <Plug>(choosewin)
let g:choosewin_label_padding      = 5
let g:choosewin_blink_on_land      = 0 " don't blink at land
let g:choosewin_statusline_replace = 1 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline

" }}}}}}
