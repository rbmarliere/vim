" ------------GENERAL-
" add eosiolib to path
set path+=/usr/local/eosio.wasmsdk/include
" use utf8 as default
set encoding=utf-8
" delete recursively with netrw
let g:netrw_localrmdir="rm -r"
" tab spacing settings
set tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab
" activating line numbers
set number
" avoiding E21: Cannot make changes, 'Modifiable' is off
set modifiable
" no warning sounds
set noerrorbells visualbell t_vb=
" autocomplete in current buffer, windows, buffers, closed buffers
set complete=.,w,b,u
" putting all swap and backup files on a specific folder
set dir=$HOME/.vim/swp/
set bdir=$HOME/.vim/bkp/
" automatically re-read file changed outside vim
set autoread
" look for tags in .git/
set tags+=.git/tags,tags,$HOME/.vim/eosiolib.tags
" when searching a word, highlight it
set hlsearch
" highlight a searching word as you type it
set incsearch
" ignore case if pattern is all lower case
set ignorecase
set smartcase
" disable distro default statusline
set statusline=
" hidden buffers
set hidden
" setting default <Leader> as a comma
let mapleader=' '
" showing trailing spaces
set list listchars=tab:\~\ ,trail:~

"------------MAPPINGS-
nnoremap - :Ex<CR>
nnoremap 50 <C-W>=
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>. :ls<CR>
nnoremap <Leader><Space> :nohlsearch<CR>
nnoremap <Leader>Q :qa<CR>
nnoremap <Leader>W :w !sudo tee % > /dev/null<CR>
nnoremap <Leader>h :vertical resize +5<CR>
nnoremap <Leader>j :resize -5<CR>
nnoremap <Leader>k :resize +5<CR>
nnoremap <Leader>l :vertical resize -5<CR>
nnoremap <Leader>rs :source ~/.vim/sessions/
nnoremap <Leader>ss :mksession! ~/.vim/sessions/
nnoremap <Leader>w :w<CR>
nnoremap P :pu<CR>
nnoremap Y y$
" Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
nnoremap <expr><silent> <Bar> v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"
nnoremap <expr><silent> _ v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"
" remove trailing spaces
nnoremap <silent> <Leader>fws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
cnoremap <expr> <CR> CCR()

"------------FUNCTIONS-
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

augroup abi
  au!
  autocmd BufNewFile,BufRead *.abi set filetype=json
augroup END

"----------PATHOGEN-
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on
set background=light
colorscheme solarized
