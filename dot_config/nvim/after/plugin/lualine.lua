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

-- Credit: https://github.com/Bekaboo/dropbar.nvim/discussions/148#discussioncomment-8668707
---Set WinBar & WinBarNC background to Normal background
---@return nil
local function clear_winbar_bg()
  ---@param name string
  ---@return nil
  local function _clear_bg(name)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    if hl.bg or hl.ctermbg then
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end

  _clear_bg('WinBar')
  _clear_bg('WinBarNC')
end

clear_winbar_bg()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('WinBarHlClearBg', {}),
  callback = clear_winbar_bg,
})
