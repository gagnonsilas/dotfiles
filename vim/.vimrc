" Disable compatibility with vi which can cause unexpected issues.
" set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Tab width settings
set tabstop=4
set shiftwidth=4
set expandtab

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Synax Highlighting
syntax on

" colemak bindings
set langmap=nj,ek,il,jn,ke,li,NJ,EK,IL,JN,KE,LI


" line numbers
set number


" window pane navigation
map <silent> <c-e> :wincmd k<CR>
nmap <silent> <c-n> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-i> :wincmd l<CR>
