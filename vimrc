" ------------GENERAL-
" https://superuser.com/questions/383457/how-to-fix-vim-textwidth-during-editing#383473
set formatoptions+=aw
" using pathogen as another submodule
runtime bundle/vim-pathogen/autoload/pathogen.vim
" delete recursively with netrw
let g:netrw_localrmdir="rm -r"
" mouse support for resizing
set mouse=n
set ttymouse=xterm2
" requiring latest vim settings (required by vundle)
set nocompatible
" syntax highlight
syntax on
" making use of system clipboard
set clipboard=unnamed
" tab spacing settings
set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
" normal backspace
set backspace=indent,eol,start
" activating line numbers
set number
" avoiding E21: Cannot make changes, 'Modifiable' is off
set modifiable
" no warning sounds
set noerrorbells visualbell t_vb=
" autocomplete in current buffer, windows, buffers, closed buffers
set complete=.,w,b,u
" line numbers are now relative to the current one
set relativenumber
" putting all swap and backup files on a specific folder
set dir=$HOME/.vim/swp/
set bdir=$HOME/.vim/bkp/
" wrap lines
set wrap
" auto writing modified buffers on switching buffers
set autowrite
" automatically re-read file changed outside vim
set autoread
" look for tags in .git/
set tags=.git/tags,tags
" horizontal splits pops below
set splitbelow
" vertical splits pops right
set splitright
" when searching a word, highlight it
set hlsearch
" highlight a searching word as you type it
set incsearch
" ignoring case, case insensitive
set ignorecase
" ignore case if pattern is all lower case
set smartcase
" always show status bar
set laststatus=2
" cool statusline from http://got-ravings.blogspot.com.br/2008/08/vim-pr0n-making-statuslines-that-own.html
"set statusline=%{expand('%:h')}/%t\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ %h%m%r%y%=%c,%l/%L\ %P
set statusline=
" better looking vert split char
set fillchars=vert:│,stl:─,stlnc:─
" showing trailing spaces
set list listchars=tab:\─\ ,trail:─
" hidden buffers
set hidden
" disabling netrw banner
"let g:netrw_banner=0
" setting default <Leader> as a comma
let mapleader=' '
" saving and restoring folds automatically
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview

"--------------COLORS-
"set term=screen-256color
set t_Co=256
set background=dark
highlight DiffAdd                 ctermbg=black ctermfg=green
highlight DiffChange              ctermbg=black ctermfg=green
highlight DiffDelete              ctermbg=black ctermfg=green
highlight DiffText                ctermbg=88    ctermfg=green
highlight StatusLine   cterm=none ctermbg=none  ctermfg=green
highlight StatusLineNC cterm=none ctermbg=none  ctermfg=28
highlight TabLine      cterm=none ctermbg=none  ctermfg=28
highlight TabLineFill  cterm=none ctermbg=none
highlight TabLineSel   cterm=none ctermbg=none  ctermfg=green
highlight VertSplit    cterm=none ctermbg=none  ctermfg=28

"------------MAPPINGS-
" disabling highlight in searching
nnoremap <Leader><Space> :nohlsearch<CR>
" clearing buffers
nnoremap <Leader>q :bufdo bd<CR>
nnoremap <Leader>Q :qa!<CR>
nnoremap <Leader>d :bd<CR>
" saving buffers
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>
cnoremap w!! w !sudo tee % >/dev/null
" tests
nnoremap <Leader>t :!clear && phpunit 
nnoremap <Leader>T :call TestFunction()<CR>
" make Y consistent with D and C
nnoremap Y y$
" paste in new line with P
nnoremap P :pu<CR>
" session management
nnoremap <Leader>ss :mksession! ~/.vim/sessions/
nnoremap <Leader>rs :source ~/.vim/sessions/
" easy navigation between splits
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
" easy creation of tabs
nnoremap <C-W><C-T> :tabe<CR>
" resize vsplit
nnoremap <Leader>h :vertical resize +5<CR>
nnoremap <Leader>l :vertical resize -5<CR>
nnoremap <Leader>k :resize +5<CR>
nnoremap <Leader>j :resize -5<CR>
nnoremap 50 <C-W>=
" Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
nnoremap <expr><silent> <Bar> v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"
nnoremap <expr><silent> _ v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"
" removing trailing spaces
nnoremap <silent> <Leader>fws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" managing buffers
nnoremap <Leader>. :ls<CR>:b
" disabling Ex Mode
"nnoremap Q <Nop>
" firing up netrw
nnoremap - :Ex<CR>
" clearing all marks
nnoremap <Leader>dm :delm! \| delm A-Z0-9<CR>
" tab cfg switch
nnoremap <Leader>chtaa :set tabstop=8 softtabstop=8 shiftwidth=8 nosmarttab noexpandtab<CR>
nnoremap <Leader>chtab :set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab<CR>
" helpers
nnoremap <Leader>v :tabe $MYVIMRC<CR>
nnoremap <Leader>x :!chmod +x %<CR>
" http://vim.wikia.com/wiki/Smart_mapping_for_tab_completion
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
cnoremap <expr> <CR> CCR()

"------------FUNCTIONS-
function! TestFunction()
	let lnum=line(".")
	let col=col(".")
	let func=getline(search("\\h\\+\\s\\+\\h\\+\\s*(.*)", 'bW'))
	let func=substitute(func, '\v(public|protected|private|function)', '', 'g')
	let func=substitute(func, '()', '', 'g')
	let func=substitute(func, ' ', '', 'g')
	let cmd="!clear && phpunit % --filter " . func
	execute cmd
	call search("\\%" . lnum . "l" . "\\%" . col .  "c")
endfunction
function! Smart_TabComplete()
	let line = getline('.')                         " current line
	let substr = strpart(line, -1, col('.')+1)      " from the start of the current line to one character right of the cursor
	let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
	if (strlen(substr)==0)                          " nothing to match on empty string
		return "\<tab>"
	endif
	let has_period = match(substr, '\.') != -1      " position of period, if any
	let has_slash = match(substr, '\/') != -1       " position of slash, if any
	if (!has_period && !has_slash)
		return "\<C-X>\<C-P>"                         " existing text matching
	elseif ( has_slash )
		return "\<C-X>\<C-F>"                         " file matching
	else
		return "\<C-X>\<C-O>"                         " plugin matching
	endif
endfunction
" make list-like commands more intuitive
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction

"------------AUTOCOMMANDS-
" :h last-position-jump
autocmd BufReadPost *
	 \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
	 \ |   exe "normal! g`\""
	 \ | endif

"------------CTRLP-
" ignore list
let g:ctrlp_user_command=['.git', 'cd %s && git ls-files -co --exclude-standard']
" we wanna search only inside the current opened folder
let g:ctrlp_working_path_mode=0
" unlimited number of files
let g:ctrlp_max_files=0
" making tags modes available by default
let g:ctrlp_extensions=['buffertag']

"------------GNUPG-
" tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1
augroup GnuPGExtra
	" set extra file options.
	autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
	" automatically close unmodified files after inactivity.
	autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END
function! SetGPGOptions()
	" set updatetime to 1 minute.
	set updatetime=60000
	" fold at markers.
	set foldmethod=marker
	" automatically close all folds.
	set foldclose=all
	" only open folds with insert commands.
	set foldopen=insert
endfunction

"--------PHPCSFIXER-
let g:php_cs_fixer_config_file=$HOME."/.php_cs"

"------PHPNAMESPACE-
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
let g:php_namespace_sort_after_insert=1

"---------PHPSYNTAX-
function! PhpSyntaxOverride()
    hi! def link phpComment SpecialKey
    hi! def link phpDocParam phpType
    hi! def link phpDocTags  phpDefine
    hi! def link phpFunctions PreProc
    hi! def link phpKeyword PreProc
    hi! def link phpMethodsVar Boolean
    hi! def link phpVarSelector Keyword
endfunction
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

"---------NAVIGATOR-
let g:tmux_navigator_save_on_switch=1

"----------PATHOGEN-
execute pathogen#infect()
syntax on
filetype plugin indent on

