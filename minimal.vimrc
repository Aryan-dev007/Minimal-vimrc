set nu
set rnu
set history=1000
set tabstop=4
set shiftwidth=4
set termguicolors
set ai
set si
colorscheme desert
set showmatch
set splitright
set noerrorbells
set novisualbell
set t_vb=
set ruler
set showcmd
set autoread
set ignorecase
set smartcase
if has('vim_starting')
	if &compatible
	       set nocompatible
       endif
endif

"Syntax enabled.
syntax on
filetype plugin indent on

"Folding by indent and folding starts at 10 lines.
set foldmethod=indent
set foldlevelstart=10
set foldnestmax=10


"Setting the same clipboard for Vim and System.
set clipboard=unnamed

"You see suggestion for commands in Airline.
set wildmenu

"Max textwidth after 80 characters new line will began.
"You can see count Airline.
set textwidth=79

"This is your leader key
:let mapleader = "\<Space>"

set guifont=Monaco:h12


"removing trailing whitspaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl<Bar> :unlet _s <CR>


"These mappings are for easy movements between mutiple splits in VIM.
"Ex- Press ctrl+j to go to split just below your cursor.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Remapped ctrl+e to go to the end of the line in INSERT mode and ctrl+a to start of the line.
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0


"Press F2 to execute javascript files.
autocmd filetype javascript nnoremap <buffer><F2> :w<CR>:!clear;node %<CR>

"Press F2 to compile and execute c and cpp files.
autocmd FileType c nnoremap <buffer> <F2> :w<CR>:!gcc -o %< % && ./%< <CR>
autocmd FileType cpp nnoremap <buffer> <F2> :w<CR>:!g++ -o %< % && ./%< <CR>

"This is for c and cpp
autocmd FileType c,cpp :set cindent
autocmd FileType c,cpp :setf c
autocmd FileType c,cpp :set expandtab

"Reload .vimrc when changes are made.
autocmd bufwritepost .vimrc source $MYVIMRC


autocmd FileType python nmap <F2> :w<CR>:!clear;python3 %<CR>

autocmd FileType typescript, vue, yaml :set sw=2 ts=2


"-----bracket completion-----------------

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap { {<Cr>}<Esc>O


"-----------------------------statusline------------------------

set laststatus=2
hi statusline       guibg=#ffaa00   guifg=#000000

" Formats the statusline
"set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
"set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor


"--------tabline----------------


