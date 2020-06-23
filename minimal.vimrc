
"===================================================================================================="
"Basic setting that are important
set nu
set rnu
set history=1000
set tabstop=4
set shiftwidth=4
"set termguicolors
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
set guifont=Monaco:h12
set confirm

"set noshowmode
set incsearch

" Show current line where the cursor is
set cursorline

"Syntax enabled.
syntax on
filetype plugin indent on

"This is your leader key
:let mapleader = "\<Space>"

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

if has('vim_starting')
	if &compatible
	       set nocompatible
       endif
endif

"Time in miliseconds to wait for mapped key sequence to complete"
set timeoutlen=500

"Cursor hold events"
set updatetime=750

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」

" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

"Show host name, full path of file and last-mod time on the window title."
set title
set titlestring=
set titlestring+=%(%{hostname()}\ \ %)
set titlestring+=%(%{expand('%:p')}\ \ %)
set titlestring+=%{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}

" Settings for popup menu
set pumheight=15  " Maximum number of items to show in popup menu
if exists("&pumblend")
    set pumblend=5  " Pesudo blend effect for popup menu
endif

"===================================================================================================="
" Change cursor shapes based on whether we are in insert mode,
if !has('macvim') "change it to 'nvim' if you are using neovim
    let &t_SI = "\<esc>[6 q"
    let &t_EI = "\<esc>[2 q"
    if exists("&t_SR")
        let &t_SR = "\<esc>[4 q"
    endif
" The number of color to use
    set t_Co=256
endif
"===================================================================================================="

"===================================================================================================="
"Bracket completion"
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
inoremap { {<Cr>}<Esc>O


"===================================================================================================="

"===================================================================================================="
"++++++++++++++++++++Key Remappings++++++++++++++

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

"<F2> to run python files"
autocmd FileType python nmap <F2> :w<CR>:!clear;python3 %<CR>

"shift width and tab stop settings "
autocmd FileType typescript, vue, yaml :set sw=2 ts=2

"removing trailing whitspaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl<Bar> :unlet _s <CR>
"===================================================================================================="

"=================================================================================================="
"+++++++++++++++++++++++FUNCTIIONS++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Custom fold expr
function! VimFolds(lnum)
    " get content of current line and the line below
    let l:cur_line = getline(a:lnum)
    let l:next_line = getline(a:lnum+1)

    if l:cur_line =~# '^"{'
        return '>' . (matchend(l:cur_line, '"{*') - 1)
    else
        if l:cur_line ==# '' && (matchend(l:next_line, '"{*') - 1) == 1
            return 0
        else
            return '='
        endif
    endif
endfunction

" Custom fold text
function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num) - 10
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' ('. folded_line_num . ' L)'
endfunction
"}

"=================================================================================================="
"+++++++++++++++++AUTOCMDS++++++++++++++++++++++++++++++++++

" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
if exists("##CmdLineEnter")
    augroup dynamic_smartcase
        autocmd!
        autocmd CmdLineEnter : set nosmartcase
        autocmd CmdLineLeave : set smartcase
    augroup END
endif

"TextWidth for text-file types. Sometimes, automatic filetype detection is not right, so we need to
"detect the filetype based on the file extensions
augroup text_file_width
    autocmd!
       autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal textwidth=79
augroup END

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END


" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

"Settings for editing vim-files"
augroup vimfile_setting
    autocmd!
    autocmd FileType vim setlocal foldmethod=expr foldlevel=0 foldlevelstart=-1
    \ foldexpr=VimFolds(v:lnum) foldtext=MyFoldText()
    \ keywordprg=:help formatoptions-=o formatoptions-=r

"================================================================================================="
"UI SETTINGS"
"
"NOTE- if not using GUI-VIM then uncomment lines 233 - 355 <<<<<<<
"augroup MyColors
    "autocmd!
    "autocmd ColorScheme * call MyHighlights()
"augroup END

"function! MyHighlights() abort
    "highlight clear

    "" The following colors are taken from ayu_mirage vim-airline theme,
    "" link: https://github.com/vim-airline/vim-airline-themes/
    "hi User1 ctermfg=0 ctermbg=114
    "hi User2 ctermfg=114 ctermbg=0

    "" The following colors are taken from vim-gruvbox8,
    "" link: https://github.com/lifepillar/vim-gruvbox8
    "hi Normal ctermfg=187 ctermbg=NONE cterm=NONE
    "hi CursorLineNr ctermfg=214 ctermbg=NONE cterm=NONE
    "hi FoldColumn ctermfg=102 ctermbg=NONE cterm=NONE
    "hi SignColumn ctermfg=187 ctermbg=NONE cterm=NONE
    "hi VertSplit ctermfg=59 ctermbg=NONE cterm=NONE

    "hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE
    "hi Comment ctermfg=102 ctermbg=NONE cterm=italic
    "hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE
    "hi Error ctermfg=203 ctermbg=234 cterm=bold,reverse
    "hi ErrorMsg ctermfg=234 ctermbg=203 cterm=bold
    "hi Folded ctermfg=102 ctermbg=237 cterm=italic
    "hi LineNr ctermfg=243 ctermbg=NONE cterm=NONE
    "hi MatchParen ctermfg=NONE ctermbg=59 cterm=bold
    "hi NonText ctermfg=239 ctermbg=NONE cterm=NONE
    "hi Pmenu ctermfg=187 ctermbg=239 cterm=NONE
    "hi PmenuSbar ctermfg=NONE ctermbg=239 cterm=NONE
    "hi PmenuSel ctermfg=239 ctermbg=109 cterm=bold
    "hi PmenuThumb ctermfg=NONE ctermbg=243 cterm=NONE
    "hi SpecialKey ctermfg=102 ctermbg=NONE cterm=NONE
    "hi StatusLine ctermfg=239 ctermbg=187 cterm=reverse
    "hi StatusLineNC ctermfg=237 ctermbg=137 cterm=reverse
    "hi TabLine ctermfg=243 ctermbg=237 cterm=NONE
    "hi TabLineFill ctermfg=243 ctermbg=237 cterm=NONE
    "hi TabLineSel ctermfg=142 ctermbg=237 cterm=NONE
    "hi ToolbarButton ctermfg=230 ctermbg=59 cterm=bold
    "hi ToolbarLine ctermfg=NONE ctermbg=59 cterm=NONE
    "hi Visual ctermfg=NONE ctermbg=59 cterm=NONE
    "hi WildMenu ctermfg=109 ctermbg=239 cterm=bold
    "hi Conceal ctermfg=109 ctermbg=NONE cterm=NONE
    "hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
    "hi DiffAdd ctermfg=142 ctermbg=234 cterm=reverse
    "hi DiffChange ctermfg=107 ctermbg=234 cterm=reverse
    "hi DiffDelete ctermfg=203 ctermbg=234 cterm=reverse
    "hi DiffText ctermfg=214 ctermbg=234 cterm=reverse
    "hi Directory ctermfg=142 ctermbg=NONE cterm=bold
    "hi EndOfBuffer ctermfg=234 ctermbg=NONE cterm=NONE
    "hi IncSearch ctermfg=208 ctermbg=234 cterm=reverse
    "hi ModeMsg ctermfg=214 ctermbg=NONE cterm=bold
    "hi MoreMsg ctermfg=214 ctermbg=NONE cterm=bold
    "hi Question ctermfg=208 ctermbg=NONE cterm=bold
    "hi Search ctermfg=214 ctermbg=234 cterm=reverse
    "hi SpellBad ctermfg=203 ctermbg=NONE cterm=italic,underline
    "hi SpellCap ctermfg=109 ctermbg=NONE cterm=italic,underline
    "hi SpellLocal ctermfg=107 ctermbg=NONE cterm=italic,underline
    "hi SpellRare ctermfg=175 ctermbg=NONE cterm=italic,underline
    "hi Title ctermfg=142 ctermbg=NONE cterm=bold
    "hi WarningMsg ctermfg=203 ctermbg=NONE cterm=bold
    "hi Boolean ctermfg=175 ctermbg=NONE cterm=NONE
    "hi Character ctermfg=175 ctermbg=NONE cterm=NONE
    "hi Conditional ctermfg=203 ctermbg=NONE cterm=NONE
    "hi Constant ctermfg=175 ctermbg=NONE cterm=NONE
    "hi Define ctermfg=107 ctermbg=NONE cterm=NONE
    "hi Debug ctermfg=203 ctermbg=NONE cterm=NONE
    "hi Delimiter ctermfg=208 ctermbg=NONE cterm=NONE
    "hi Error ctermfg=203 ctermbg=234 cterm=bold,reverse
    "hi Exception ctermfg=203 ctermbg=NONE cterm=NONE
    "hi Float ctermfg=175 ctermbg=NONE cterm=NONE
    "hi Function ctermfg=142 ctermbg=NONE cterm=bold
    "hi Identifier ctermfg=109 ctermbg=NONE cterm=NONE
    "hi Ignore ctermfg=fg ctermbg=NONE cterm=NONE
    "hi Include ctermfg=107 ctermbg=NONE cterm=NONE
    "hi Keyword ctermfg=203 ctermbg=NONE cterm=NONE
    "hi Label ctermfg=203 ctermbg=NONE cterm=NONE
    "hi Macro ctermfg=107 ctermbg=NONE cterm=NONE
    "hi Number ctermfg=175 ctermbg=NONE cterm=NONE
    "hi Operator ctermfg=107 ctermbg=NONE cterm=NONE
    "hi PreCondit ctermfg=107 ctermbg=NONE cterm=NONE
    "hi PreProc ctermfg=107 ctermbg=NONE cterm=NONE
    "hi Repeat ctermfg=203 ctermbg=NONE cterm=NONE
    "hi SpecialChar ctermfg=203 ctermbg=NONE cterm=NONE
    "hi SpecialComment ctermfg=203 ctermbg=NONE cterm=NONE
    "hi Statement ctermfg=203 ctermbg=NONE cterm=NONE
    "hi StorageClass ctermfg=208 ctermbg=NONE cterm=NONE
    "hi Special ctermfg=208 ctermbg=NONE cterm=italic
    "hi String ctermfg=142 ctermbg=NONE cterm=italic
    "hi Structure ctermfg=107 ctermbg=NONE cterm=NONE
    "hi Todo ctermfg=fg ctermbg=234 cterm=bold,italic
    "hi Type ctermfg=214 ctermbg=NONE cterm=NONE
    "hi Typedef ctermfg=214 ctermbg=NONE cterm=NONE
    "hi Underlined ctermfg=109 ctermbg=NONE cterm=underline
    "hi CursorIM ctermfg=NONE ctermbg=NONE cterm=reverse

    "hi Comment cterm=NONE
    "hi Folded cterm=NONE
    "hi SpellBad cterm=underline
    "hi SpellCap cterm=underline
    "hi SpellLocal cterm=underline
    "hi SpellRare cterm=underline
    "hi Special cterm=NONE
    "hi String cterm=NONE
    "hi Todo cterm=bold

    "hi NormalMode ctermfg=137 ctermbg=234 cterm=reverse
    "hi InsertMode ctermfg=109 ctermbg=234 cterm=reverse
    "hi ReplaceMode ctermfg=107 ctermbg=234 cterm=reverse
    "hi VisualMode ctermfg=208 ctermbg=234 cterm=reverse
    "hi CommandMode ctermfg=175 ctermbg=234 cterm=reverse
    "hi Warnings ctermfg=208 ctermbg=234 cterm=reverse
"endfunction

"if exists("&termguicolors")
    "" If we want to use true colors, we must a color scheme which support true
    "" colors, for example, https://github.com/sickill/vim-monokai
    "set notermguicolors
"endif
""set background=dark
"colorscheme desert
"========================TERMINAL Settings END================="

" statusline settings
set laststatus=2
hi statusline       guibg=blue   guifg=white "If using terminal comment out these two lines.
hi LineNr guibg=NONE guifg=green

" Formats the statusline
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'Replace',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set statusline=
" Show current mode
set statusline+=\ %{toupper(g:currentmode[mode()])}

set statusline+=\ %=                            " align left
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]                         "file format

set statusline+=%h                               "help file flag

set statusline+=%y                               "filetype
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor




