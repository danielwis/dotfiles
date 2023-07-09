-- Setup navic first
local navic = require("nvim-navic")

vim.api.nvim_set_hl(0, "NavicText", { link = "Comment" })
vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Comment" })

navic.setup {
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

-- Now do lualine
require('lualine').setup {
    winbar = {
        lualine_c = {
            "navic",
            color_correction = nil,
            navic_opts = nil
        }
    }
}
