--
-- Colourscheme
--
require("gruvbox").setup({
    contrast = "hard",
    overrides = {
        SignColumn = { link = "Normal" },            -- Remove signcolumn background.
        CursorLineNr = { bg = "none", bold = true }, -- Make cursorline number bold and with remove bg

        ErrorMsg = { fg = "#fb4934", bg = "none" },  -- Red text on no bg looks cleaner in the number column.
        WarningMsg = { fg = "#ffbf00" },             -- Warning should not be red imo
        -- Other signcolumn things?
        -- GruvboxGreenSign = { bg = "" },
        -- GruvboxOrangeSign = { bg = "" },
        -- GruvboxPurpleSign = { bg = "" },
        -- GruvboxYellowSign = { bg = "" },
        -- GruvboxRedSign = { bg = "" },
        -- GruvboxBlueSign = { bg = "" },
        -- GruvboxAquaSign = { bg = "" },
    },
})
vim.cmd("colorscheme gruvbox")

--
-- Breadcrumbs/code context
--
vim.api.nvim_set_hl(0, "NavicText", { link = "Comment" })
vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Comment" })

require("nvim-navic").setup {
    lsp = {
        auto_attach = true,
        preference = nil,
    },
    highlight = true,
    -- separator = " " .. EcoVim.icons.caretRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true
}

vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>");

--
-- Statusline (bottom)
--
require('lualine').setup {
    options = {
        theme = 'gruvbox'
    },
    winbar = {
        lualine_c = {
            "navic",
            color_correction = nil,
            navic_opts = nil
        }
    }
}

--
-- Bufferline (top)
--
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

--
-- Indent prettyfier
--
require("ibl").setup()

--
-- Git indicators
--
require('gitsigns').setup({
    -- almost default settings (delay decreased from 1000)
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 750,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle [B]lame' })
    end
})
