-- Autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip") -- For certain mappings (tab behaviour)

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    sources = cmp.config.sources({
        { name = 'nvim_lsp',                max_item_count = 10 },
        { name = 'luasnip',                 max_item_count = 10 },
        { name = 'nvim_lsp_signature_help', max_item_count = 10 },
        { name = 'path',                    max_item_count = 10 },
        { name = 'buffer',                  max_item_count = 10 },
        -- Do we want spelling suggestions? I'll leave it in here
        -- just in case, but it can get pretty intense.
        -- { name = 'spell',                   max_item_count = 10 },
    }, {
        { name = 'buffer' },
    })
})
