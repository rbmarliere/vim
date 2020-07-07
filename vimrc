runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
set background=dark
colorscheme solarized
set t_Co=256
set clipboard=unnamedplus
set encoding=utf-8
set tabstop=8 softtabstop=8 shiftwidth=8 nosmarttab noexpandtab
"set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
set number
set complete=.,w,b,u
set dir=$HOME/.vim/swp/
set bdir=$HOME/.vim/bkp/
set autoread
set tags+=.git/tags,tags,$HOME/.tags
set hlsearch
set incsearch
set ignorecase
set smartcase
let mapleader=' '
set list listchars=tab:\~\ ,trail:~
set statusline=%{expand('%:h')}/%t\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ %h%m%r%y%=%c,%l/%L\ %P
set laststatus=2
let g:python_recommended_style = 0

nnoremap <Leader>1 1gt
nnoremap <Leader>2 2gt
nnoremap <Leader>3 3gt
nnoremap <Leader>4 4gt
nnoremap <Leader>5 5gt
nnoremap <Leader>0 :tablast<CR>
nnoremap - :Ex<CR>
nnoremap <C-w><C-t> :tabe<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader><Space> :nohlsearch<CR>
nnoremap <Leader>Q :qa<CR>
nnoremap <Leader>H :vertical resize +5<CR>
nnoremap <Leader>J :resize -5<CR>
nnoremap <Leader>K :resize +5<CR>
nnoremap <Leader>L :vertical resize -5<CR>
nnoremap <Leader>rs :source ~/.vim/sessions/
nnoremap <Leader>ss :mksession! ~/.vim/sessions/
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :w !sudo tee % > /dev/null<CR>
nnoremap P :pu<CR>
nnoremap Y y$
nnoremap <expr><silent> <Bar> v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"
nnoremap <expr><silent> _ v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"
nnoremap <silent> <Leader>fws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
cnoremap <expr> <CR> CCR()

function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction

let g:GPGPreferArmor=1
augroup GnuPGExtra
	autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
	autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END
function! SetGPGOptions()
	set updatetime=60000
	set foldmethod=marker
	set foldclose=all
	set foldopen=insert
endfunction

