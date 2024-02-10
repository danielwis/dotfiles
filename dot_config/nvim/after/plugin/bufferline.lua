vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        numbers = "buffer_id",
        diagnostics = "nvim_lsp",
    }
}

vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" });
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" });
vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close buffer" })
for i = 1, 9 do
	vim.keymap.set("n", "<A-" .. i .. ">", "<cmd>b " .. i .. "<CR>")
end
