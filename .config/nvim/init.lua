vim.g.mapleader = " "

require('remaps')
--require('nvim-cmp')
-- require('nrpattern').setup()
require('plugins')
require('options')

-- Flash the text being yanked
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'Visual',
            timeout = 90,
        })
    end,
})

-- Auto remove trailing whitespace
autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})
