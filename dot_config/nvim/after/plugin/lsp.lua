-- Don't slow down neovim on LSP start.
-- See https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
    -- disable lsp watcher. Too slow on linux
    wf._watchfunc = function()
        return function() end
    end
end

-- Setup language servers.
local lspconfig = require('lspconfig')

-- What to run when an LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { remap = false, buffer = bufnr }

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<space>e', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', '<space>q', function() vim.diagnostic.setloclist() end, opts)

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wl', print(vim.inspect(vim.lsp.buf.list_workspace_folders)), opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        if vim.lsp.get_client_by_id(ev.data.client_id).server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(0, true)
        end
    end
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'pyright', 'ruff_lsp', 'rust_analyzer', 'lua_ls', 'clangd', 'denols', 'texlab' }
local server_settings = {
    ["rust_analyzer"] = {
        ['rust-analyzer'] = { check = { command = "clippy" } },
    },
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
local filetypes = {
    ['denols'] = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'markdown',
        'json',
    },
}

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        settings = server_settings[lsp],
        filetypes = filetypes[lsp],
    }
end
