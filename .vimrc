"Basic setting that are important
set nu
set rnu
set history=1000
set tabstop=4
set shiftwidth=4
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
set path+=**
set backspace=indent,eol,start
execute "set <M-j>=\ej"
"Use of alt+j !! wooh! finally "How?
"Open your terminal and type "sed -n l" or "cat"
"press the key combination you want to map i got "^[j"
"replace "^[" with "\e" because that's just escape character.
"Then do something like this
execute "set <M-j>=\ej"
"map your key as you want them to like "nnoremap <M-j> foo(any method)"
"I mapped it for compiling and execution of file



"set noshowmode
set incsearch

" Show current line where the cursor is
set cursorline

"Syntax enabled.
syntax on
filetype plugin indent on

"This is your leader key
:let mapleader = "\<Space>"

"Code Folding
set foldenable
set foldmethod=manual
set foldlevelstart=10
set foldnestmax=100
augroup remember_folds
	  autocmd!
	  autocmd BufWinLeave * mkview
	  autocmd BufWinEnter * silent! loadview
augroup END




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

let g:netrw_banner=0             " disable annoying banner
let g:netrw_browse_split=4       " open in prior windows
let g:netrw_liststyle=3          " Tree view
let g:netrw_altv=1               " open splits to the right
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(|\s\s\)\zs\.\S\+'


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


"Press Alt-j to execute javascript files.
autocmd filetype javascript nnoremap <buffer> <M-j>  :w<CR>:!clear;node %<CR>

"Press Alt-j to compile and execute c and cpp files.
au FileType c,cpp nnoremap <buffer> <M-j> :w<CR> :make %<<CR> :term ./%<<CR>
"if your it shows some message instead of your result do :copen to check your errors


"This is for c and cpp
autocmd FileType c,cpp :set cindent
autocmd FileType c,cpp :setf c
autocmd FileType c,cpp :set expandtab

"Reload .vimrc when changes are made.
autocmd bufwritepost .vimrc source $MYVIMRC

" Alt-j  to run python files"
autocmd FileType python nmap <M-j> :w<CR>:!clear;python3 %<CR>

"shift width and tab stop settings "
autocmd FileType typescript, vue, yaml :set sw=2 ts=2

"Automatically remove all trailing whitespaces on saving file.
autocmd BufWritePre * :%s/\s\+$//e


"===================================================================================================="

"=================================================================================================="
"+++++++++++++++++AUTOCMDS++++++++++++++++++++++++++++++++++

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

	"================================================================================================="
	"UI SETTINGS"
	"
	"NOTE- if not using GUI-VIM then uncomment lines 233 - 355 <<<<<<<
	augroup MyColors
		autocmd!
		autocmd ColorScheme * call MyHighlights()
	augroup END

	function! MyHighlights() abort
		highlight clear

		"" The following colors are taken from ayu_mirage vim-airline theme,
		"" link: https://github.com/vim-airline/vim-airline-themes/
		hi User1 ctermfg=0 ctermbg=114
		hi User2 ctermfg=114 ctermbg=0

		"" The following colors are taken from vim-gruvbox8,
		"" link: https://github.com/lifepillar/vim-gruvbox8
		hi Normal ctermfg=187 ctermbg=NONE cterm=NONE
		hi CursorLineNr ctermfg=214 ctermbg=NONE cterm=NONE
		hi FoldColumn ctermfg=102 ctermbg=NONE cterm=NONE
		hi SignColumn ctermfg=187 ctermbg=NONE cterm=NONE
		hi VertSplit ctermfg=59 ctermbg=NONE cterm=NONE

		hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE
		hi Comment ctermfg=102 ctermbg=NONE cterm=italic
		hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE
		hi Error ctermfg=203 ctermbg=234 cterm=bold,reverse
		hi ErrorMsg ctermfg=234 ctermbg=203 cterm=bold
		hi Folded ctermfg=102 ctermbg=237 cterm=italic
		hi LineNr ctermfg=243 ctermbg=NONE cterm=NONE
		hi MatchParen ctermfg=NONE ctermbg=59 cterm=bold
		hi NonText ctermfg=239 ctermbg=NONE cterm=NONE
		hi Pmenu ctermfg=187 ctermbg=239 cterm=NONE
		hi PmenuSbar ctermfg=NONE ctermbg=239 cterm=NONE
		hi PmenuSel ctermfg=239 ctermbg=109 cterm=bold
		hi PmenuThumb ctermfg=NONE ctermbg=243 cterm=NONE
		hi SpecialKey ctermfg=102 ctermbg=NONE cterm=NONE
		hi StatusLine ctermfg=239 ctermbg=187 cterm=reverse
		hi StatusLineNC ctermfg=237 ctermbg=137 cterm=reverse
		hi TabLine ctermfg=243 ctermbg=237 cterm=NONE
		hi TabLineFill ctermfg=243 ctermbg=237 cterm=NONE
		hi TabLineSel ctermfg=142 ctermbg=237 cterm=NONE
		hi ToolbarButton ctermfg=230 ctermbg=59 cterm=bold
		hi ToolbarLine ctermfg=NONE ctermbg=59 cterm=NONE
		hi Visual ctermfg=NONE ctermbg=59 cterm=NONE
		hi WildMenu ctermfg=109 ctermbg=239 cterm=bold
		hi Conceal ctermfg=109 ctermbg=NONE cterm=NONE
		hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
		hi DiffAdd ctermfg=142 ctermbg=234 cterm=reverse
		hi DiffChange ctermfg=107 ctermbg=234 cterm=reverse
		hi DiffDelete ctermfg=203 ctermbg=234 cterm=reverse
		hi DiffText ctermfg=214 ctermbg=234 cterm=reverse
		hi Directory ctermfg=142 ctermbg=NONE cterm=bold
		hi EndOfBuffer ctermfg=234 ctermbg=NONE cterm=NONE
		hi IncSearch ctermfg=208 ctermbg=234 cterm=reverse
		hi ModeMsg ctermfg=214 ctermbg=NONE cterm=bold
		hi MoreMsg ctermfg=214 ctermbg=NONE cterm=bold
		hi Question ctermfg=208 ctermbg=NONE cterm=bold
		hi Search ctermfg=214 ctermbg=234 cterm=reverse
		hi SpellBad ctermfg=203 ctermbg=NONE cterm=italic,underline
		hi SpellCap ctermfg=109 ctermbg=NONE cterm=italic,underline
		hi SpellLocal ctermfg=107 ctermbg=NONE cterm=italic,underline
		hi SpellRare ctermfg=175 ctermbg=NONE cterm=italic,underline
		hi Title ctermfg=142 ctermbg=NONE cterm=bold
		hi WarningMsg ctermfg=203 ctermbg=NONE cterm=bold
		hi Boolean ctermfg=175 ctermbg=NONE cterm=NONE
		hi Character ctermfg=175 ctermbg=NONE cterm=NONE
		hi Conditional ctermfg=203 ctermbg=NONE cterm=NONE
		hi Constant ctermfg=175 ctermbg=NONE cterm=NONE
		hi Define ctermfg=107 ctermbg=NONE cterm=NONE
		hi Debug ctermfg=203 ctermbg=NONE cterm=NONE
		hi Delimiter ctermfg=208 ctermbg=NONE cterm=NONE
		hi Error ctermfg=203 ctermbg=234 cterm=bold,reverse
		hi Exception ctermfg=203 ctermbg=NONE cterm=NONE
		hi Float ctermfg=175 ctermbg=NONE cterm=NONE
		hi Function ctermfg=142 ctermbg=NONE cterm=bold
		hi Identifier ctermfg=109 ctermbg=NONE cterm=NONE
		hi Ignore ctermfg=fg ctermbg=NONE cterm=NONE
		hi Include ctermfg=107 ctermbg=NONE cterm=NONE
		hi Keyword ctermfg=203 ctermbg=NONE cterm=NONE
		hi Label ctermfg=203 ctermbg=NONE cterm=NONE
		hi Macro ctermfg=107 ctermbg=NONE cterm=NONE
		hi Number ctermfg=175 ctermbg=NONE cterm=NONE
		hi Operator ctermfg=107 ctermbg=NONE cterm=NONE
		hi PreCondit ctermfg=107 ctermbg=NONE cterm=NONE
		hi PreProc ctermfg=107 ctermbg=NONE cterm=NONE
		hi Repeat ctermfg=203 ctermbg=NONE cterm=NONE
		hi SpecialChar ctermfg=203 ctermbg=NONE cterm=NONE
		hi SpecialComment ctermfg=203 ctermbg=NONE cterm=NONE
		hi Statement ctermfg=203 ctermbg=NONE cterm=NONE
		hi StorageClass ctermfg=208 ctermbg=NONE cterm=NONE
		hi Special ctermfg=208 ctermbg=NONE cterm=italic
		hi String ctermfg=142 ctermbg=NONE cterm=italic
		hi Structure ctermfg=107 ctermbg=NONE cterm=NONE
		hi Todo ctermfg=fg ctermbg=234 cterm=bold,italic
		hi Type ctermfg=214 ctermbg=NONE cterm=NONE
		hi Typedef ctermfg=214 ctermbg=NONE cterm=NONE
		hi Underlined ctermfg=109 ctermbg=NONE cterm=underline
		hi CursorIM ctermfg=NONE ctermbg=NONE cterm=reverse
		hi LineNr ctermfg=green ctermbg=NONE
		hi statusline ctermfg=black ctermbg=green

		hi Comment cterm=NONE
		hi Folded cterm=NONE
		hi SpellBad cterm=underline
		hi SpellCap cterm=underline
		hi SpellLocal cterm=underline
		hi SpellRare cterm=underline
		hi Special cterm=NONE
		hi String cterm=NONE
		hi Todo cterm=bold

		hi NormalMode ctermfg=137 ctermbg=234 cterm=reverse
		hi InsertMode ctermfg=109 ctermbg=234 cterm=reverse
		hi ReplaceMode ctermfg=107 ctermbg=234 cterm=reverse
		hi VisualMode ctermfg=208 ctermbg=234 cterm=reverse
		hi CommandMode ctermfg=175 ctermbg=234 cterm=reverse
		hi Warnings ctermfg=208 ctermbg=234 cterm=reverse
	endfunction

	if exists("&termguicolors")
		"" If we want to use true colors, we must a color scheme which support true
		"" colors, for example, https://github.com/sickill/vim-monokai
		set notermguicolors
	endif
	set background=dark
	colorscheme desert
	"========================TERMINAL Settings END================="

	" statusline settings
	set laststatus=2
	"hi statusline       guibg=blue   guifg=white "If using terminal comment out these two lines.
	"hi LineNr guibg=NONE guifg=green

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

	"CTRL-N for autocompletion in case you forget it.
	"Ctrl-x-f for path completion
	"Use :help ins-completion"


	"First set complier using :complier
	"Use :make command for compiling or running the program.
	"Use :cope to see error in seperate window aka QuickFix Window
	"Awesome isn't it!!!!!!!
	"But now you don't need to do all this just press Alt+j and you're good to go
