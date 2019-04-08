set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set visualbell

set incsearch
set hlsearch
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

set number
set showmatch " Blinks the closing brackets to show match
set matchtime=2 " Hundreds of milliseconds to show the matching parent
set virtualedit=block " Cursor block limit gone only in <C-V> mode
syntax on
set t_Co=256
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

"
" Backups

set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


" Automatically install Vim Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim Plug zone
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-signify'
Plug 'ervandew/supertab'



call plug#end()

