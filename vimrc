"=========================== SCRIPT  and PLUGIN =====================
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'weilbith/nerdtree_choosewin-plugin'
Plug 't9md/vim-choosewin'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-peekaboo'

Plug 'Valloric/MatchTagAlways'
Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'Yggdroot/hiPairs'
Plug 'Yggdroot/indentLine'
Plug 'RRethy/vim-illuminate'

Plug 'godlygeek/tabular'
" Plug 'Raimondi/delimitMate'
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'djoshea/vim-autoread'
Plug 'mbbill/undotree'

Plug 'plasticboy/vim-markdown'

Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

"Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json', {'for' : 'json'}

"Tmux
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'christoomey/vim-tmux-navigator'


Plug 'ervandew/supertab'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer --java-completer' }
let g:python3_host_prog = '/usr/local/bin/python3'


Plug 'dense-analysis/ale'

Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" let g:airline_extensions = []

"Themes
Plug 'fatih/molokai'
" Plug 'patstockwell/vim-monokai-tasty'
" let g:airline_theme='monokai_tasty'


call plug#end()
"=========================== script and plugin=====================================


"=================================  SETTINGS ===================================

set nocompatible              " be iMproved, required
filetype off
filetype plugin indent on


set ttyfast

set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set mouse=a                     "Enable mouse mode
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow                 " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set title
if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif
set number    	 		"line number on
set showcmd			"display an incomplate command in statusline
set showmatch 			"highlight matching [{()}]
" set matchpairs=<:>  
set cursorline
set wildmenu
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
set completeopt=menu,menuone,longest,preview
set updatetime=300
set ruler

"search
set incsearch  			 " Shows the match while typing
set hlsearch   			 " Highlight found searches
set ignorecase               " Search case insensitive...
set smartcase

set clipboard^=unnamed
set clipboard^=unnamedplus

syntax enable	"syntax enable
set t_Co=256
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai


" Toggle paste
set pastetoggle=<F9>

autocmd FileType html,css,xml,htmldjango set tabstop=4 shiftwidth=4 softtabstop=4 expandtab ai
setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
au BufNewFile,BufRead *.html set filetype=htmldjango 
let g:html_indent_inctags = "html,body,head,tbody,a"
let b:html_omni_flavor = 'html5'
"=================================== settings =========================================


"=============================== MAPPINGS ===================================

let mapleader = ","

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :ccl<CR>

" Exit on j
imap jj <Esc>

" Fast saving
nnoremap <leader>w :w!<cr>

" Center the screen
nnoremap <space> zz

"
imap <S-j> <Esc>o

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Close all but the current one
nnoremap <leader>o :only<CR>

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

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" print file full path
map <C-f> :echo expand("%:p")<cr>

" Source (reload configuration)
nnoremap <silent> <F5> :source $MNVIMRC<CR>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
"==============================  mappings ==============================================


"======================================= PLUGINS ================================

"========================= vim-airline ====================
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#tabline#left_sep = "  "
"let g:airline#extensions#tabline#left_alt_sep = "  "
""
" Tab line
"highlight TabLine      ctermfg=White  ctermbg=236     cterm=NONE
"highlight TabLineFill  ctermfg=White  ctermbg=236     cterm=NONE
"highlight TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE


let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype', 'fileencoding', 'fileformat' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2c',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': []
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
      \ },
      \ }

"=========================================================

"==================== vim-signify ========================
nnoremap <silent><leader>p :SignifyHunkDiff<cr>
nnoremap <silent><leader>u :SignifyHunkUndo<cr>
"========================================================

"========================== ale ==========================
let g:ale_linters = {
			\ 'python': ['flake8'],
			\}
let g:ale_fixers = {
			\  'javascript': ['eslint'],
\}
"=========================================================

"========================= supertab ===========================
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:SuperTabMappingBackward = '<s-c-space>'
"=============================================================

"===================== YouCompleteMe ==========================
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" let g:ycm_global_ycm_extra_conf = '~/.vim/global_extra_conf.py'

let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ', ':'],
    \   'python': [ 're!\w{2}' ],
    \   'javascript': [ 're!\w{2}' ],
    \   'java': [ 're!\w{2}' ],
    \ }
"=============================================================

" =========== Completion + Snippet ==============
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"===================================================

"========================= undotree ==================
nnoremap <f3>  :UndotreeToggle<cr>
let g:undotree_WindowLayout=2
let g:undotree_DiffpanelHeight=8
let g:undotree_SetFocusWhenToggle=1
"======================================================

"======= FZF ====================
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~20%' }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" search
nmap <C-p> :FzfHistory<cr>
imap <C-p> <esc>:<C-u>FzfHistory<cr>

" search across files in the current directory
nmap <C-b> :FzfFiles<cr>
imap <C-b> <esc>:<C-u>FzfFiles<cr>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


"================================


"=========== NERDTree =============
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI=1
let NERDTreeMapOpenSplit      = 's'
let NERDTreeMapOpenVSplit     = 'v'
let NERDTreeIgnore=['.DS_Store', '\.pyc$', '^__pycache__$']
let NERDTreeRespectWildIgnore=1
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0

let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
"===================================

"============ Nerdtree git plugin ======
let g:NERDTreeGitStatusIndicatorMap = {
        \ 'Modified'  : '✹',
        \ 'Staged'    : '✚',
        \ 'Untracked' : '✭',
        \ 'Renamed'   : '➜',
        \ 'Unmerged'  : '═',
        \ 'Deleted'   : '✖',
        \ 'Dirty'     : '✗',
        \ 'Clean'     : '✔︎',
        \ 'Ignored'   : '',
        \ 'Unknown'   : '?'
        \ }
"========================================

"========== vim-illumunati ============
let g:Illuminate_ftblacklist = ['nerdtree', 'gitconfig','fugitive', 'git']"
hi illuminatedWord ctermbg=236 ctermfg=None cterm=None
"=====================================

"=========== tagbar ==========
nmap <F8> :TagbarToggle<CR>

let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
"=============================

"=========== RainbowParentheses ==========
augroup rainbow_list
  autocmd!
  autocmd FileType python RainbowParentheses
augroup END
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
"=============================

"=========== hiPairs ==========
"    let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
"                \                  'cterm'   : 'underline,bold',
"                \                  'ctermfg' : 'NONE',
"                \                  'ctermbg' : '143',
"                \                  'gui'     : 'underline,bold',
"                \                  'guifg'   : 'NONE',
"                \                  'guibg'   : 'NONE' }
"=============================

"=================== ack ======================
cnoreabbrev Ack Ack!
let g:ackprg = 'ag --vimgrep --smart-case'
" let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ack_mappings = {
      \ "t": "<C-W><CR><C-W>T",
      \ "T": "<C-W><CR><C-W>TgT<C-W>j",
      \ "o": "<CR>",
      \ "O": "<CR><C-W><C-W>:ccl<CR>",
      \ "go": "<CR><C-W>j",
      \ "s": "<C-W><CR><C-W>K",  
      \ "S": "<C-W><CR><C-W>K<C-W>b",
      \ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
      \ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J" 
      \ } 
"===============================================

"================ vim-javascript ===========
let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
"=============================================

"================ vim-jsx =====================
let g:jsx_ext_required = 0
"===============================================

"================ vim-json ===================
let g:vim_json_syntax_conceal = 0
"=============================================

"============== vim-markdown =================
let g:vim_markdown_folding_disabled = 1
"===========================================


"======================= delimitMate ======================
" let g:delimitMate_expand_cr = 1
" let g:delimitMate_expand_space = 1
" let g:delimitMate_smart_quotes = 1
" let g:delimitMate_expand_inside_quotes = 0
" let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

let g:AutoPairsFlyMode = 1

"==========================================================

"======================== indentLine ========================
let g:indentLine_enabled = 1
let g:indentLine_color_term = 87
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_first_char='┊'
let g:indentLine_char = '┆'
let g:indentLine_bufNameExclude = ['startify']
"===========================================================

"============= Pymode ==============
let g:pymode_python = 'python3'
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
"===================================

"======== vim-choosin =========
" invoke with '-'
nmap  -  <Plug>(choosewin)
let g:choosewin_label_padding = 5
let g:choosewin_blink_on_land      = 0 " don't blink at land
let g:choosewin_statusline_replace = 1 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline
"=============================
"
"=============================== plugins ==============================================
