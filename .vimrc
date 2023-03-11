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
" Make folds based off of syntax.
" Also, don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows. Yoinked shamelessly from
" https://vim.fandom.com/wiki/Keep_folds_closed_while_inserting_text
set foldmethod=syntax
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" All folds open on start
set nofoldenable
" Save/load fold state automatically
au BufWinLeave *.* mkview
au BufWinEnter *.* silent! loadview
" Use space to fold/unfold
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
Plug 'SirVer/ultisnips'                 " Snippets
Plug 'lervag/vimtex'                    " Lots of LaTeX support
Plug 'preservim/nerdtree'               " Visual file browsing
Plug 'tpope/vim-surround'               " Surround text objects with things (parens, quotes etc.)
Plug 'tpope/vim-repeat'                 " Extend the . command to things like vim-surround
Plug 'vim-airline/vim-airline'          " Nice status bar at the bottom of the screen
Plug 'vim-airline/vim-airline-themes'   " Themes for vim-airline
Plug 'vim-syntastic/syntastic'          " Advanced syntax highlighting
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" NerdTree
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

" Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '❕'
let g:syntastic_style_error_symbol = '›'
let g:syntastic_style_warning_symbol = '›'

" Gutentags
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
            \ '--tag-relative=yes',
            \ '--fields=+ailmnS',
            \ ]
:set tags=./tags; " Look for tags recursively (current folder --> /)

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

function! CharCount()
    let filename = expand("%")
    let cmd = "detex " . filename . " | tr -d '[:space:]' | wc -c"
    echo system(cmd) . " characters"
endfunction

command WC call WC()
command CharCount call CharCount()




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
