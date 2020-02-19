"=========================== SCRIPT  and PLUGIN =====================
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'weilbith/nerdtree_choosewin-plugin', { 'on':  'NERDTreeToggle' }
Plug 't9md/vim-choosewin'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'junegunn/vim-peekaboo'

Plug 'Valloric/MatchTagAlways'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'
Plug 'RRethy/vim-illuminate'
Plug 'unblevable/quick-scope'
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-overwin-f2)'}
Plug 'mattn/emmet-vim', {'for': ['html', 'htmldjango']}

Plug 'junegunn/vim-easy-align', {'on': '<plug>(LiveEasyAlign)'}
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'  }

" Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}

Plug 'SirVer/ultisnips'
Plug 'tayfunoztan/vim-snippets'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

"Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'rust-lang/rust.vim', { 'for': 'rust' }

Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json', {'for' : 'json'}

"Tmux
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'christoomey/vim-tmux-navigator'


Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --clang-completer --ts-completer' }
let g:python3_host_prog = '/usr/local/bin/python3'

Plug 'dense-analysis/ale', {'on': 'ALEToggle'}

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

"Themes
Plug 'fatih/molokai'
Plug 'mhartington/oceanic-next'
Plug 'liuchengxu/space-vim-dark'
Plug 'tpope/vim-vividchalk'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark='dark'

call plug#end()
"=========================== script and plugin=====================================


"=================================  SETTINGS ===================================

set nocompatible              " be iMproved, required
filetype off
filetype plugin indent on

set encoding=utf-8              " Set default encoding to UTF-8

"indent settings
set autoindent
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2

" backup/swap/info/undo settings
set noswapfile         " Don't use swapfile
set nobackup           " Don't create annoying backup files
set undofile
set undodir=~/.cache/vim
" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :FzfHistory uses it
set viminfo='500

"better navigation
set cursorline
set hlsearch    " Highlight found searches
set ignorecase  " Search case insensitive...
set incsearch   " Shows the match while typing
set smartcase
set mouse=a     "Enable mouse mode

"misc settings
set autoread                    " Automatically reread changed files without asking me anything
set autowrite                " Automatically save before :next, :make etc.
set backspace=indent,eol,start  " Makes backspace key more powerful.
set clipboard=unnamed
" set clipboard^=unnamed
" set clipboard^=unnamedplus
" set completeopt=menu,menuone,longest ",preview
set completeopt=menuone ",preview
set complete-=i
set pumheight=10
set lazyredraw
set pastetoggle=<F9> " Toggle paste
set splitright               " Split vertical windows right to the current windows
set splitbelow                 " Split horizontal windows below to the current windows
set title
set nojoinspaces
set ttyfast
set splitbelow
set splitright

"wild stuff
set wildmode=full
set wildmenu
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,.idea

"display 
set laststatus=2
set ruler
set showcmd    "display an incomplate command in statusline
set number     "line number on
set showmatch "highlight matching [{()}]
set noshowmode
set nostartofline
set list
set listchars=tab:\|\ ,
set shortmess=aoOTI
" set matchpairs=<:>  

set updatetime=300

"breaking
set wrap
set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

syntax enable "syntax enable
set t_Co=256
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

let g:seoul256_background = 234
let g:space_vim_dark_background = 234

autocmd FileType html,css,xml,htmldjango set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
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

" new line insert mode
imap <S-j> <Esc>o

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <tab>   <c-w>w

" East tab navigation
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Visual linewise up and down by default (and use gj gk to go quicker)
" noremap <Up> gk
" noremap <Down> gj
noremap j gj
noremap k gk

" window resize 
nnoremap <left>   <c-w>>
nnoremap <right>  <c-w><
nnoremap <up>     <c-w>-
nnoremap <down>   <c-w>+

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
" qq to record, Q to replay
nnoremap Q @q

" print file full path
map <C-f> :echo expand("%:p")<cr>

" Source (reload configuration)
nnoremap <silent> <F5> :source $MYVIMRC<CR>

" Visual Mode */# from Scrooloose {{{
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

nnoremap g. :normal! `[v`]<cr><left>
"==============================  mappings ==============================================


"======================================= PLUGINS ================================

"====================== lightline ===========================
let g:lightline = {
       \ 'colorscheme': 'toztan',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'gitbranch'] ],
       \   'right': [ [ 'filetype', 'fileencoding', 'fileformat' ] ]
       \ },
       \ 'inactive': {
       \   'left': [ [ 'filename', 'gitbranch'] ],
       \   'right': [ [ 'filetype', 'fileencoding', 'fileformat' ] ]
       \ },
       \ 'component': {
       \ },
       \ 'component_function': {
       \   'gitbranch': 'gitbranch#name',
       \   'filename': 'LightlineFilename',
       \   'fileformat': 'LightlineFileformat',
       \   'filetype': 'LightlineFiletype',
       \   'fileencoding': 'LightlineFileencoding',
       \   'mode': 'LightlineMode',
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

function! LightlineModified()
 return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
 return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
 let fname = @%
 return fname == '__Tagbar__.1' ? g:lightline.fname :
       \ fname =~ 'NERD_tree_1' ? split(b:NERDTree.root.path.str(), '/')[-1] :
       \ fname =~ 'undotree_2' ? 'UndoTree' :
       \ fname =~ 'diffpanel_3' ? 'DiffPanel' :
       \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != fname ? fname : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineMode()
 let fname = expand('%:t')
 return fname == '__Tagbar__.1' ? 'Tagbar' :
       \ fname =~ 'NERD_tree_1' ? 'NERDTree' :
       \ fname =~ 'undotree_2' ? 'UndoTree' :
       \ fname =~ 'diffpanel_3' ? 'DiffPanel' :
       \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 50 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 50 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 50 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
   let g:lightline.fname = a:fname
 return lightline#statusline(0)
endfunction
"=========================================================

"==================== vim-signify ========================
let g:signify_vcs_list = ['git']
nnoremap <silent><leader>p :SignifyHunkDiff<cr>
nnoremap <silent><leader>u :SignifyHunkUndo<cr>

highlight SignifySignAdd guifg=#87ff5f ctermfg=119 guibg=#3a3a3a ctermbg=237 gui=bold cterm=bold
highlight SignifySignDelete guifg=#df5f5f ctermfg=167 guibg=#3a3a3a ctermbg=237 gui=bold cterm=bold
highlight SignifySignChange guifg=#ffff5f ctermfg=227 guibg=#3a3a3a ctermbg=237 gui=bold cterm=bold
"========================================================

"=================== matchtagalway =====================
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=white ctermbg=red guifg=black guibg=lightgreen
"=======================================================

"========================== ale ==========================
let g:ale_enabled=0
let g:airline#extensions#ale#enabled=0
let g:ale_linters = {
			\ 'python': ['flake8'],
			\}
let g:ale_fixers = {
			\  'javascript': ['eslint'],
\}
"=========================================================

"=================== easy-motion ==========================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
" nmap s <Plug>(easymotion-overwin-w)

highlight EasyMotionTarget guifg=#ffff5f ctermfg=227 guibg=NONE ctermbg=NONE gui=bold cterm=bold
highlight EasyMotionTarget2First guifg=#df005f ctermfg=161 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight EasyMotionTarget2Second guifg=#ffff5f ctermfg=227 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
"==========================================================

"==================== vim-easy-align =====================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"========================================================

"===================== YouCompleteMe ==========================
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_use_ultisnips_completer = 1
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_max_num_identifier_candidates = 10

let g:ycm_key_list_select_completion   = ['<TAB>', '<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_global_extra_conf.py'

let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ', ':'],
    \ }

"=============================================================

" =========== Completion + Snippet ==============
let g:UltiSnipsUsePythonVersion = 3
" let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"===================================================

"========================= undotree ==================
nnoremap <f3>  :UndotreeToggle<cr>
let g:undotree_WindowLayout       = 2
let g:undotree_DiffpanelHeight    = 8
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 0
"======================================================

"==================  FZF ====================
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
"=========================================


"=========== NERDTree =============
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden                = 1
let g:NERDTreeMouseMode               = 2
let g:NERDTreeWinSize                 = 30
let g:NERDTreeMinimalUI               = 1
let NERDTreeMapOpenSplit              = 's'
let NERDTreeMapOpenVSplit             = 'v'
let NERDTreeIgnore                    = ['.DS_Store', '\.pyc$', '^__pycache__$', '.git']
let NERDTreeRespectWildIgnore         = 1
let NERDTreeCascadeSingleChildDir     = 0
let NERDTreeCascadeOpenSingleChildDir = 0

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('py', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('md', 'Magenta', 'none', '#ff00ff', '#151515')

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
let g:Illuminate_ftblacklist = ['nerdtree', 'gitconfig','fugitive', 'git']
hi illuminatedWord ctermbg=238 ctermfg=None cterm=None
"=====================================

"=========== tagbar ==========
nmap <F8> :TagbarToggle<CR>

let g:tagbar_compact   = 1
let g:tagbar_autofocus = 1
"=============================

"=========== RainbowParentheses ==========
augroup rainbow_list
  autocmd!
  autocmd FileType python RainbowParentheses
  autocmd FileType java RainbowParentheses
augroup END
let g:rainbow#pairs = [['(', ')'], ['[', ']']]
"=============================

"======================= hiPairs =================
"    let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
"                \                  'cterm'   : 'underline,bold',
"                \                  'ctermfg' : 'NONE',
"                \                  'ctermbg' : '143',
"                \                  'gui'     : 'underline,bold',
"                \                  'guifg'   : 'NONE',
"                \                  'guibg'   : 'NONE' }
"===============================================

"=================== ack ======================
" cnoreabbrev Ack Ack!
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
" let g:javascript_plugin_flow = 1
" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END
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

"======================== indentLine ========================
let g:indentLine_enabled              = 1
let g:indentLine_color_term           = 239 "87
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char           = '┊'
let g:indentLine_char                 = '┆'
let g:indentLine_bufNameExclude       = ['startify']
"===========================================================

"============= Pymode ==============
let g:pymode_python          = 'python3'
let g:pymode_options         = 0
let g:pymode_doc             = 0
let g:pymode_motion          = 1
let g:pymode_lint            = 0
let g:pymode_rope            = 0
let g:pymode_rope_completion = 0
"===================================

"======== vim-choosin =========
" invoke with '-'
nmap  -  <Plug>(choosewin)
let g:choosewin_label_padding      = 5
let g:choosewin_blink_on_land      = 0 " don't blink at land
let g:choosewin_statusline_replace = 1 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline
"=============================

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"=============================== plugins ==============================================
