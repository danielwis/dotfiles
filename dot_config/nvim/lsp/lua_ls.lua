return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = {
        ["lua_ls"] = {
            Lua = {
                diagnostics = {
                    globals = { 'vim', 'use' },
                    disable = { 'undefined-global' },
                },
                hint = {
                    enable = true,
                },
            },
        }
    }
}
