" Don't try to be compatible with vi
set nocompatible
set noerrorbells

syntax on

set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
" set nowrap
" Don't restrict to lowercase results just because search term is lowercase
set ignorecase
" But do restrict to upper if term is upper
set smartcase
set noswapfile
set incsearch
set encoding=utf-8
set conceallevel=2
set undofile
set undodir=~/.vim/undodir

" Spellcheck (TODO: Use ftplugins instead?)
" autocmd FileType latex,tex,md,markdown setlocal spell spelllang=en_gb
" Shamelessly stolen from Gilles Castel's blog
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" -------------------------------------
"            P L U G I N S
" -------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'lervag/vimtex'
call plug#end()

" Do not highlight conceals, bold text etc
hi clear Conceal
hi texBoldStyle ctermbg=NONE
hi SpellBad ctermbg=grey
hi SpellRare ctermbg=grey
" To see different text types, type :source /usr/share/vim/vim82/syntax/hitest.vim
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" -------------------------------------
"          F U N C T I O N S
" -------------------------------------
" Copied from StackExchange (https://tex.stackexchange.com/a/590) - a simple word
" counting function for LaTeX documents.
function! WC()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w | tr -d '[:space:]'"
    let result = system(cmd)
    echo result . " words"
endfunction

command WC call WC()





" Mode Settings

" let &t_SI = "\<Esc>[6 q"
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"
" let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
" let &t_SI.="\e[6 q" "SI = INSERT mode
" let &t_SR.="\e[4 q" "SR = REPLACE mode

" Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
