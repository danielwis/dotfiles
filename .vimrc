" Don't try to be compatible with vi
set nocompatible
set noerrorbells

syntax on
set encoding=utf-8

" Line numbers
set number
set relativenumber

" Tab size, and make tabs into spaces
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

" Indent new lines based on previous lines
set smartindent

" set nowrap
"
" Don't restrict to lowercase results just because search term is lowercase
set ignorecase
" But do restrict to upper if term is upper
set smartcase

set noswapfile
set incsearch
set conceallevel=2
set laststatus=2 " Status always on

" Undo file for un/re-doing across closes
set undofile
set undodir=~/.vim/undodir

""" Folds
set foldmethod=syntax " Make folds based off of syntax
" Save fold state
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview
set nofoldenable
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

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
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Toggle NerdTree with Ctrl-n
nnoremap <C-n> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Powerline theme
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

" Do not highlight conceals, bold text etc
hi clear Conceal
hi texBoldStyle ctermbg=NONE
hi SpellBad ctermbg=grey
hi SpellRare ctermbg=grey
hi Folded ctermfg=White
hi Folded ctermbg=Black
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
