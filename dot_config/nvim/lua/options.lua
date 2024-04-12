-----------------------------
--- General customisation ---
-----------------------------
vim.opt.syntax = "on"
vim.opt.errorbells = false
vim.opt.mouse = 'n' -- Only in normal mode

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab size, and make tabs into spaces
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true

-- Indent new lines based on previous lines
vim.opt.smartindent = true

-- Make split direction unstupid
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Don't restrict to lowercase results just because search term is lowercase
vim.opt.ignorecase = true
-- But do restrict to upper if term is upper
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.conceallevel=2

-- Undo file for un/re-doing across closes
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.updatetime = 50

---------------
--- THEMING ---
---------------
-- Color scheme (everforest specific)
vim.opt.termguicolors = true

-- Set contrast.
-- This configuration option should be placed before `colorscheme everforest`.
-- Available values: 'hard', 'medium'(default), 'soft'
vim.g.everforest_transparent_background = 1
-- For better performance
vim.g.everforest_better_performance = 1
vim.cmd('colorscheme everforest')

-- Powerline theme
-- let g:airline_theme='bubblegum'
vim.g.airline_theme = 'everforest'
vim.g.airline_powerline_fonts = 1

-- Override theme defaults to make bold. Can change colour with guifg=col
vim.cmd[[hi CursorLineNr gui=bold]]
-- Do not highlight conceals, bold text etc
vim.cmd[[hi clear Conceal]]
vim.cmd[[hi texBoldStyle ctermbg=NONE]]
vim.cmd[[hi SpellBad ctermbg=grey]]
vim.cmd[[hi SpellRare ctermbg=grey]]
vim.cmd[[hi Folded ctermfg=White]]
vim.cmd[[hi Folded ctermbg=Black]]
-- To see different text types, type :source /usr/share/vim/vim82/syntax/hitest.vim


----------------------
--- Plugin options ---
----------------------
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='zathura_simple'
vim.g.vimtex_quickfix_mode=0
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"


-------------
--- Folds ---
-------------
-- Make folds based off of syntax.
-- Also, don't screw up folds when inserting text that might affect them, until
-- leaving insert mode. Foldmethod is local to the window. Protect against
-- screwing up folding when switching between windows. Yoinked shamelessly from
-- https://vim.fandom.com/wiki/Keep_folds_closed_while_inserting_text
-- set foldmethod=syntax
vim.o.foldmethod="expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
-- autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

-- All folds open on start, but also save/load fold state automatically
vim.opt.foldenable = false
vim.cmd[[set viewoptions-=options]]
local augroup = vim.api.nvim_create_augroup('remember_folds', {clear = true})
vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*.*',
  group = augroup,
  command = 'mkview'
})
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*.*',
  group = augroup,
  command = 'silent! loadview'
})
-- Use space to fold/unfold (clashes with lsp mappings)
-- nnoremap <Space> foldlevel('.') ? 'za' : '<Space>'
-- vnoremap <Space> zf



-----------------
--- Functions ---
-----------------
-- Copied from StackExchange (https://tex.stackexchange.com/a/590) - a simple word
-- counting function for LaTeX documents.
-- function! WC()
    -- let filename = expand("%")
    -- let cmd = --detex -- . filename . -- | wc -w | tr -d '[:space:]'--
    -- let result = system(cmd)
    -- echo result . " words"
-- endfunction

-- command WC call WC()
