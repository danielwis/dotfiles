vim.keymap.set('n', '<leader>ex', ':Ex<CR>')

-- Move lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ'z") -- Keep cursor at beginning of line when joining
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Yank into system clipboard with <leader>y
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('v', '<leader>y', '"+y')

-- Delete into void register with leader
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end)

-- TODO: Checkout Quickfix (and implement Primeagen keymaps for it

-- Replace all instaces of the word underneath the cursor
-- TODO: Make this available only if LSP is not running. Right now, just rely on LSP.
-- vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable (for scripts etc)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
