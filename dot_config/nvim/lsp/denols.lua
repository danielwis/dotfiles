return {
    cmd = { "deno", "lsp" },
    cmd_env = { NO_COLOR = true, },
    -- TODO: What is this? Used by default in lspconfig
    -- handlers= {
    --   ["textDocument/definition"] = <function 1>,
    --   ["textDocument/references"] = <function 1>,
    --   ["textDocument/typeDefinition"] = <function 1>
    -- },
    root_markers = { 'deno.json', 'deno.jsonc', '.git' },
    settings = {
        deno = {
            enable = true,
            suggest = {
                imports = {
                    hosts = {
                        ["https://deno.land"] = true
                    }
                }
            }
        }
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'markdown',
        'json',
    }
}
