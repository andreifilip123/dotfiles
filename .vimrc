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

" Utility
Plug 'scrooloose/nerdtree' " Navigation tree
Plug 'kien/ctrlp.vim' " Search for file
Plug 'itchyny/lightline.vim' " That nice line at the bottom of this file
Plug 'ervandew/supertab' "Autocompletion using tab
Plug 'tpope/vim-commentary' " Comment using gc or gcc
Plug 'Raimondi/delimitMate' " Auto insert brackets/quotes/etc
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Search in all project

" Languages
Plug 'sheerun/vim-polyglot' " Collection of languages
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'othree/javascript-libraries-syntax.vim'


call plug#end()

syntax on
colorscheme monokai
set t_Co=256
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" Remap ctrlp to cmd T
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]node_modules$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_working_path_mode = 'ra'

" NERDTree config
nmap <C-E> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=30
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

