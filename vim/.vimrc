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
bindings

" colemak bindings
nnoremap q q
vnoremap q q
nnoremap w w
vnoremap w w
nnoremap f e
vnoremap f e
nnoremap p r
vnoremap p r
nnoremap g t
vnoremap g t
nnoremap j y
vnoremap j y
nnoremap l u
vnoremap l u
nnoremap u i
vnoremap u i
nnoremap y o
vnoremap y o
nnoremap ; p
vnoremap ; p
nnoremap a a
vnoremap a a
nnoremap r s
vnoremap r s
nnoremap s d
vnoremap s d
nnoremap t f
vnoremap t f
nnoremap d g
vnoremap d g
nnoremap h h
vnoremap h h
nnoremap n j
vnoremap n j
nnoremap e k
vnoremap e k
nnoremap i l
vnoremap i l
nnoremap o ;
vnoremap o ;
nnoremap z z
vnoremap z z
nnoremap x x
vnoremap x x
nnoremap c c
vnoremap c c
nnoremap v v
vnoremap v v
nnoremap b b
vnoremap b b
nnoremap k n
vnoremap k n
nnoremap m m
vnoremap m m

" line numbers
set number

