call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Search in all project

call plug#end()

inoremap jk <ESC>

" Map cmd shift E to NERDTreeToggle
nmap @@ :NERDTreeToggle<CR>

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Map cmd / to NERDCommenter
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" Remap cmd shift F to find
nnoremap !! :Ag<CR>

" Remap ctrlp to cmd shift T
let g:ctrlp_map = '##'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules\|ios\/build\|ios\/.*\.xcworkspace\|ios\/.*\.xcodeproj\|ios\/Pods\|android\/app\/build$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_working_path_mode = 'ra'

" Don't use separate clipboard for vim
set clipboard=unnamed

" Fix typos
command! Q :q
command! Qa :qa
command! QA :qa
command! W :w

" Ignore node_modules
let g:NERDTreeIgnore = ['^node_modules$']

" ---- Highlight current file ----
" sync open file with NERDTree
" " Check if NERDTree is open or active
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
" ---- End highlight current file ----

set incsearch
set hlsearch
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
