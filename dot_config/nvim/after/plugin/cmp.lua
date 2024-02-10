-- Autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip") -- For certain mappings (tab behaviour)

-- Forget snippets once exited instead of jumping around in the buffer to old ones.
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        -- Luasnip specific mappings (allows tab and shift-tab to assume
        -- different behaviour depending on where in the text we currently
        -- are).
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                --[[ Don't open autocomplete menu with tab
            elseif has_words_before() then
                cmp.complete()
            ]]
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    -- A source group below another won't show until there are
    -- no completion items for the one above.
    -- Also, unintuitively, items lower in the list have higher priority.
    sources = cmp.config.sources({
        { name = 'nvim_lua',                priority = 7, max_item_count = 10 },
        { name = 'nvim_lsp',                priority = 5 },
        { name = 'luasnip',                 priority = 3, max_item_count = 10 },
        { name = 'nvim_lsp_signature_help', priority = 1, max_item_count = 10 },
        -- Do we want spelling suggestions? I'll leave it in here
        -- just in case, but it can get pretty intense.
        -- { name = 'spell',                   max_item_count = 10 },
    }, {
        { name = 'path', },
        { name = 'buffer' },
    }),

    experimental = {
        ghost_text = true,
    },
    view = {
        entries = 'native'
    },
})
