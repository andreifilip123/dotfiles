set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set visualbell
set t_vb=

set incsearch
set hlsearch
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

set number
set showmatch " Blinks the closing brackets to show match
set matchtime=2 " Hundreds of milliseconds to show the matching parent
set virtualedit=block " Cursor block limit gone only in <C-V> mode
set autoindent
set smartindent
filetype indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set cursorline
set scrolloff=999
set ruler
set ignorecase
set smartcase
set noerrorbells

"
" Folding -----------------------------------------------------------------

" Options & Mappings

set foldenable "Enable code folding

set foldlevelstart=0
set foldmethod=syntax

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

set laststatus=2
set noshowmode
set clipboard=unnamed
set fileformat=unix " new line endings
set ttyfast " faster terminal
set undofile " Save undo history in a file
set undoreload=10000 " Costly for Memory
set title " Show the title in window bar
set autowrite
set autoread
set mousehide "Hide mouse when typing
set shell=zsh
set wildignore+=*/tmp/*,*/node_modules/*     " MacOSX/Linux

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null
command! Q :q
command! Qa :qa
command! QA :qa
command! W :w

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

"
" Line Return

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Automatically install Vim Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim Plug zone
call plug#begin('~/.vim/plugged')

" Basics
Plug 'tpope/vim-sensible'

" Looks
Plug 'crusoexia/vim-monokai' " Monokai Theme
Plug 'mhinz/vim-signify' " Show git diff signs before lines
Plug 'fortes/vim-escuro'

" Utility
Plug 'scrooloose/nerdtree' " Navigation tree
Plug 'jistr/vim-nerdtree-tabs' " Tabs for NERDTree
Plug 'kien/ctrlp.vim' " Search for file
Plug 'itchyny/lightline.vim' " That nice line at the bottom of this file
Plug 'ervandew/supertab' "Autocompletion using tab
Plug 'tpope/vim-commentary' " Comment using gc or gcc
Plug 'Raimondi/delimitMate' " Auto insert brackets/quotes/etc
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Search in all project
Plug 'pakutoma/toggle-terminal' " Toggle :terminal
Plug 'vim-syntastic/syntastic' " ESLint and stuff
Plug 'w0rp/ale' " ESLint and stuff
Plug 'zivyangll/git-blame.vim' " Git blame

" Languages
Plug 'sheerun/vim-polyglot' " Collection of languages
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'othree/javascript-libraries-syntax.vim'


call plug#end()

let mapleader = ","
syntax on
syntax enable
color escuro
set t_Co=256
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" Remap ctrlp to cmd T
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules\|ios\/build\|ios\/.*\.xcworkspace\|ios\/.*\.xcodeproj\|ios\/Pods\|android\/app\/build$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_working_path_mode = 'ra'

" FZF
nnoremap <silent> <Leader>f :Ag<CR>

" NERDTree config
nmap <Leader>n :NERDTreeTabsToggle<CR>
let g:NERDTreeWinSize=30
let g:nerdtree_tabs_open_on_console_startup=1

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

nnoremap . <NOP>
nmap <Leader>s :write<Enter>
set termwinsize=15x0
set splitbelow
tnoremap <silent> <Leader>. <C-w>:ToggleTerminal<CR>
nnoremap <silent> <Leader>. :ToggleTerminal<CR>
let g:toggle_terminal#command = 'zsh'

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" Open images in vim (requires iterm)
autocmd BufEnter *.png,*.jpg,*gif exec "! ~/.iterm2/imgcat ".expand("%") | :bw

" Configure Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

let g:ale_fixers = {
\  'javascript': ['eslint']
\}

