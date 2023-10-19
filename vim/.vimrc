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
set langmap=qq,ww,fe,pr,gt,jy,lu,ui,yo,aa,rs,sd,tf,dg,hh,nj,ek,il,zz,xx,cc,vv,bb,kn,mm,QQ,WW,FE,PR,GT,JY,LU,UI,YO,:P,AA,RS,SD,TF,DG,HH,NJ,EK,IL,O:,ZZ,XX,CC,VV,BB,KN,MM


nnoremap ; p
nnoremap o ;
vnoremap ; p
vnoremap o ;

" line numbers
set number

