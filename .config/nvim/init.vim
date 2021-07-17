" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ============================================================================
" vim-plug {{{
" ============================================================================
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tayfunoztan/ReplaceWithRegister'

Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'kyazdani42/nvim-tree.lua'

Plug 'lewis6991/gitsigns.nvim'

Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'christoomey/vim-tmux-navigator'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Plug 'hoob3rt/lualine.nvim'
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
  let g:gruvbox_contrast_dark='hard'

call plug#end()

augroup vimrc
  autocmd!
augroup END

lua require 'init'

" }}}
" ============================================================================
" options {{{
" ============================================================================

set encoding=utf-8             " Set default encoding to UTF-8
set number                     " line number on
set autoindent
set smartindent
" set lazyredraw
set laststatus=2
set showcmd                    " display an incomplate command in statusline
set backspace=indent,eol,start " Makes backspace key more powerful.
set timeoutlen=500
set whichwrap=b,s
set shortmess+=c               " Shut off completion messages
set hlsearch                   " Highlight found searches
set incsearch                  " Shows the match while typing
set hidden
set ignorecase                 " Search case insensitive...
set smartcase
set wildmenu
set wildmode=full
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,.idea
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set scrolloff=5
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread                   " Automatically reread changed files without asking me anything
set autowrite                  " Automatically save before :next, :make etc.
set clipboard=unnamed
set completeopt=menuone,noselect
set cursorline
set mouse=a                    " Enable mouse mode
set complete-=i
set pumheight=15
" set pastetoggle=<F9>           " Toggle paste
set splitright                 " Split vertical windows right to the current windows
set splitbelow                 " Split horizontal windows below to the current windows
set title
set ttyfast
set updatetime=300
set showmatch                  " highlight matching [{()}]
set noshowmode
set signcolumn=yes

" backup/swap/info/undo settings
set nobackup
set nowritebackup
set undofile
set noswapfile
set backupdir  -=.
set shada       ='100

set formatoptions =tcrqnj
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr

set modelines=2

" Keep the cursor on the same column
set nostartofline

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax enable
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

" }}}
" ============================================================================
" mappings {{{
" ============================================================================
" ----------------------------------------------------------------------------
" basic mappings
" ----------------------------------------------------------------------------
let mapleader = ","

" Exit on j
imap jj <Esc>

" Fast saving
nnoremap <leader>w :w!<cr>

" Center the screen
nnoremap <space> zz

" new line insert mode
" imap <S-j> <Esc>o

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" nnoremap <tab>   <c-w>w

" Movement in insert mode
" inoremap <C-h> <C-o>h
" inoremap <C-l> <C-o>l
" inoremap <C-j> <C-o>j
" inoremap <C-k> <C-o>k

" Moving line in visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Do not show stupid q: window
map q: :q

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" nnoremap <left>   <c-w>>
" nnoremap <right>  <c-w><
" nnoremap <up>     <c-w>-
" nnoremap <down>   <c-w>+

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" qq to record, Q to replay
nnoremap Q @q

" print file full path
map <C-f> :echo expand("%:p")<cr>

" Source (reload configuration)
nnoremap <silent> <F5> :source $MYVIMRC<CR>

" Visual Mode */# from Scrooloose 
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Close all but the current one
nnoremap <leader>o :only<CR>

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" ----------------------------------------------------------------------------
" quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

nnoremap <leader>T :vsplit +terminal<cr>
tnoremap jj <c-\><c-n>
"}}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================
augroup vimrc
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
  autocmd FileType python,javascript,scheme RainbowParentheses

  autocmd FileType vue setlocal commentstring=<!--\ %s\ -->

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/


  " run :GoBuild or :GoTestCompile based on the go file
  " function! s:build_go_files()
  "   let l:file = expand('%')
  "   if l:file =~# '^\f\+_test\.go$'
  "     call go#test#Test(0, 1)
  "   elseif l:file =~# '^\f\+\.go$'
  "     call go#cmd#Build(0)
  "   endif
  " endfunction

  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  " autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


  " Close preview window
  " if exists('##CompleteDone')
  "   au CompleteDone * pclose
  " else
  "   au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  " endif

  " Automatic rename of tmux window
  " if exists('$TMUX') && !exists('$NORENAME')
  "   au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
  "   au VimLeave * call system('tmux set-window automatic-rename on')
  " endif

  " cursorline only active window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
"}}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================
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
"}}}
" ============================================================================
" PLUGINS {{{
" ============================================================================
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

" ----------------------------------------------------------------------------
" nvim-tree
" ----------------------------------------------------------------------------
let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_disable_window_picker = 0 "0 by default, will disable the window picker.
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.DS_Store' ] "empty by default
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': " ",
    \   'arrow_closed': " ",
    \   'default': "▶",
    \   'open': "▼",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

let g:nvim_tree_disable_default_keybindings = 1
lua <<EOF
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    -- default mappings
    vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "v",                        cb = tree_cb("vsplit") },
      { key = "s",                        cb = tree_cb("split") },
      { key = "t",                        cb = tree_cb("tabnew") },
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
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }
EOF

nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>m :NvimTreeFindFile<CR>

"}}}
