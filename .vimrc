set hlsearch
set number
syntax on
set t_Co=256
set autoindent
filetype indent on
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set cursorline
set scrolloff=999
set ruler
set ignorecase
set smartcase
set noerrorbells
set foldmethod=syntax
set laststatus=2
set noshowmode
set encoding=utf-8
set clipboard=unnamed


" Automatically install Vim Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim Plug zone
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'


call plug#end()

