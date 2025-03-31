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
