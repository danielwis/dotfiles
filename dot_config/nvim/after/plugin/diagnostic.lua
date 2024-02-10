-- Much of this is taken from TJ DeVries' dotfiles.
vim.diagnostic.config {
    underline = true,
    virtual_text = {
        severity = nil,
        source = "if_many",
        format = nil,
    },
    signs = true,

    -- options for floating windows:
    float = {
        show_header = true,
        -- border = "rounded",
        -- source = "always",
        format = function(d)
            if not d.code and not d.user_data then
                return d.message
            end

            local t = vim.deepcopy(d)
            local code = d.code
            if not code then
                if not d.user_data.lsp then
                    return d.message
                end

                code = d.user_data.lsp.code
            end
            if code then
                t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
            end
            return t.message
        end,
    },

    -- Display more severe errors first
    severity_sort = true,
}

-- Go to the next diagnostic, but prefer going to errors first (until there are no more)
local severity_levels = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
}

local get_highest_error_severity = function()
    for _, level in ipairs(severity_levels) do
        local diags = vim.diagnostic.get(0, { severity = { min = level } })
        if #diags > 0 then
            return level, diags
        end
    end
end

local opts = { remap = false, buffer = bufnr }
vim.keymap.set('n', "<space>dn",
    function()
        vim.diagnostic.goto_next {
            severity = get_highest_error_severity(),
            wrap = true,
            float = true,
        }
    end,
    opts
)

vim.keymap.set('n',
    "<leader>dp",
    function()
        vim.diagnostic.goto_prev {
            severity = get_highest_error_severity(),
            wrap = true,
            float = true,
        }
    end,
    opts
)
