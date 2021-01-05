"====================================================
" vimrc
"===================================================

augroup vimrc
  autocmd!
augroup END

let g:plug_shallow = 0
let g:plug_window = '-tabnew'
let g:plug_pwindow = 'vertical rightbelow new'

let s:darwin = has('mac')

"=========================== SCRIPT and PLUGIN =====================
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 't9md/vim-choosewin'
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-overwin-f2)'}
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'  }
Plug 'tayfunoztan/ReplaceWithRegister'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'Valloric/MatchTagAlways'
Plug 'michaeljsmith/vim-indent-object'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'justinmk/vim-gtfo'

Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
  autocmd! User indentLine doautocmd indentLine Syntax
  let g:indentLine_color_term = 239

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/gv.vim', {'on': 'GV'}
Plug 'junegunn/rainbow_parentheses.vim'
  let g:rainbow#blacklist = [9, 13, 15, 234, 248]
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/vim-after-object'
"   autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')

" Plug 'sgur/vim-editorconfig'
if exists('##TextYankPost')
  Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 200
endif

"tmux
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tmux-plugins/vim-tmux-focus-events'

if v:version >= 800
  Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
  " Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['c', 'cpp']}

"python
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'vim-python/python-syntax'
  let g:python_highlight_all = 1
  let g:python_highlight_space_errors = 0
Plug 'Vimjas/vim-python-pep8-indent'

"rust
" Plug 'rust-lang/rust.vim', {'for': 'rust'}

"go
" Plug 'fatih/vim-go'
" let g:go_code_completion_enabled = 0

"javascript, html 
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'alvan/vim-closetag'
  let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'

Plug 'itchyny/lightline.vim'

Plug 'dense-analysis/ale', {'on': 'ALEToggle'}
  let g:ale_linters = {'python': ['flake8']}
  let g:ale_fixers = {'python': ['black']}
  let g:ale_lint_delay = 1000
  nmap ]a <Plug>(ale_next_wrap)
  nmap [a <Plug>(ale_previous_wrap)

"theme
Plug 'fatih/molokai'
  let g:molokai_original = 1
  let g:rehash256 = 1
Plug 'junegunn/seoul256.vim'
  let g:seoul256_background = 234
Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark='hard'
Plug 'tayfunoztan/vim-tomorrow-theme'

call plug#end()
"=========================== script and plugin=====================================

let g:python3_host_prog = '/usr/local/bin/python3'

"=================================  SETTINGS ===================================

set encoding=utf-8              " Set default encoding to UTF-8

"indent settings
set autoindent
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set scrolloff=5

" backup/swap/info/undo settings
set noswapfile         " Don't use swapfile
set nobackup           " Don't create annoying backup files
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo
endif
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
set diffopt=filler,vertical
set autoread                    " Automatically reread changed files without asking me anything
set autowrite                " Automatically save before :next, :make etc.
set backspace=indent,eol,start  " Makes backspace key more powerful.
set clipboard=unnamed
" set clipboard^=unnamed
" set clipboard^=unnamedplus
" set completeopt=menu,menuone,longest ",preview
set completeopt=menuone,preview
set complete-=i
set pumheight=15
set lazyredraw
set pastetoggle=<F9> " Toggle paste
set splitright               " Split vertical windows right to the current windows
set splitbelow                 " Split horizontal windows below to the current windows
set title
set nojoinspaces
set ttyfast
set hidden
set splitbelow
set splitright

"wild stuff
set wildmenu
set wildmode=full
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
set virtualedit=block
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
" set t_Co=256
set background=dark
colorscheme Tomorrow-Night-Bright
"=================================== settings =========================================

"=============================== MAPPINGS ===================================

let mapleader = ","

" Some useful quickfix shortcuts for quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
nnoremap <leader>c :cclose<bar>lclose<cr>

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

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

" East tab navigation
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

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

nnoremap <left>   <c-w>>
nnoremap <right>  <c-w><
nnoremap <up>     <c-w>-
nnoremap <down>   <c-w>+

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

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

if has('nvim')
  nnoremap <leader>T :vsplit +terminal<cr>
  tnoremap jj <c-\><c-n>
endif
"==============================  mappings ==============================================

augroup vimrc
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
  autocmd FileType python,javascript,scheme RainbowParentheses

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

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
" ----------------------------------------------------------------------------

"======================================= PLUGINS ================================
"=================================== coc-nvim =============================
if has_key(g:plugs, 'coc.nvim')
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  imap <C-j> <Plug>(coc-snippets-expand-jump)

  inoremap <silent><expr> <c-space> coc#refresh()

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  nmap <leader>rn <Plug>(coc-rename)

  let g:coc_global_extensions = ['coc-yaml',
    \ 'coc-python', 'coc-rls',  'coc-html', 'coc-json', 'coc-css', 'coc-html',
    \ 'coc-prettier', 'coc-eslint', 'coc-tsserver', 'coc-snippets']

  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  let g:go_doc_keywordprg_enabled = 0

  augroup coc-config
    autocmd!
    autocmd VimEnter * nmap <silent> [d <Plug>(coc-diagnostic-prev)
    autocmd VimEnter * nmap <silent> ]d <Plug>(coc-diagnostic-next)
    autocmd VimEnter * nmap <silent> gd <Plug>(coc-definition)
    autocmd VimEnter * nmap <silent> gy <Plug>(coc-type-definition)
    autocmd VimEnter * nmap <silent> gi <Plug>(coc-implementation)
    autocmd VimEnter * nmap <silent> gr <Plug>(coc-references)
  augroup END
endif
"============================================================================

"====================== lightline ===========================
let g:lightline = {
       \ 'colorscheme': 'toztan3',
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'coc' ] ],
       \   'right': [ [ 'filetype', 'fileencoding', 'fileformat' ] ]
       \ },
       \ 'inactive': {
       \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'coc'] ],
       \   'right': [ [ 'filetype', 'fileencoding', 'fileformat' ] ]
       \ },
       \ 'component': {
       \ },
       \ 'component_function': {
       \   'fugitive': 'LightlineFugitive',
       \   'filename': 'LightlineFilename',
       \   'fileformat': 'LightlineFileformat',
       \   'filetype': 'LightlineFiletype',
       \   'fileencoding': 'LightlineFileencoding',
       \   'mode': 'LightlineMode',
       \   'coc': 'Coc',
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

function! Coc()
 return winwidth(0) > 80 ? get(b:,"coc_current_function","") : ''
endfunction

function! LightlineReadonly()
 return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 80 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 60 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 80 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'diffpanel\|undotree\|Tagbar\|NERD' && exists('*FugitiveHead')
      let mark = ''  " edit here for cool mark
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilename()
 let fname = @%
 return fname =~# '^__Tagbar__' ? g:lightline.fname :
       \ fname =~# 'NERD_tree' ? split(b:NERDTree.root.path.str(), '/')[-1] :
       \ fname =~# 'undotree' ? 'UndoTree' :
       \ fname =~# 'diffpanel' ? 'DiffPanel' :
       \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != fname ? fname : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineMode()
 let fname = expand('%:t')
 return fname =~# '^__Tagbar__' ? 'Tagbar' :
       \ fname =~# 'NERD_tree' ? 'NERDTree' :
       \ fname =~# 'undotree' ? 'UndoTree' :
       \ fname =~# 'diffpanel' ? 'DiffPanel' :
       \ winwidth(0) > 60 ? lightline#mode() : ''
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
"========================================================

"==================== vim-startify ========================
let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'
"========================================================

"=========== tagbar ==========================
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width     = 35
"=============================================

"=================== easy-motion ==========================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
" nmap s <Plug>(easymotion-overwin-w)
"==========================================================

"==================== vim-easy-align =====================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"========================================================

"========================= undotree ==================
nnoremap U :UndotreeToggle<cr>
let g:undotree_WindowLayout       = 2
let g:undotree_DiffpanelHeight    = 8
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 0
"======================================================

"=========================  FZF ========================
let $FZF_DEFAULT_OPTS .= ' --inline-info'

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

" All files
command! -nargs=? -complete=dir ALLFILES
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Identifier'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Function'],
  \ 'pointer': ['fg', 'Identifier'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Structure'] }

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" search history
nnoremap <silent> <C-p> :FzfHistory<CR>
" imap <C-p> <esc>:<C-u>FzfHistory<cr>

" search across files in the current directory
nnoremap <silent> <C-b> :FzfFiles<CR>
" imap <C-b> <esc>:<C-u>FzfFiles<cr>

nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FzfFiles\<cr>"
nnoremap <silent> <Leader>b :FzfBuffers<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
"=======================================================

"======================== indentLine ========================
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char           = '|'
let g:indentLine_char                 = '|'
let g:indentLine_bufNameExclude       = ['startify', 'Tagbar']
let g:indentLine_fileTypeExclude      = ['json']
"===========================================================

"======================== vim-choosin =====================
" invoke with '-'
nmap  -  <Plug>(choosewin)
let g:choosewin_label_padding      = 5
let g:choosewin_blink_on_land      = 0 " don't blink at land
let g:choosewin_statusline_replace = 1 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline
"==========================================================

"=================== matchtagalway =====================
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
let g:mta_filetypes = { 'html' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1, 'htmldjango' : 1, 'javascript': 1}
highlight MatchTag ctermfg=white ctermbg=93 guifg=black guibg=lightgreen
"=======================================================

"============================= NERDTree =================
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden                = 1
let g:NERDTreeMouseMode               = 2
let g:NERDTreeWinSize                 = 30
let g:NERDTreeMinimalUI               = 0
let NERDTreeMapOpenSplit              = 's'
let NERDTreeMapOpenVSplit             = 'v'
let NERDTreeIgnore                    = ['.DS_Store', '\.pyc$', '^__pycache__$', '.git/', 'node_modules']
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
"========================================================
"=============================== plugins ==============================================
