-- require'lspconfig'.clangd.setup{}
-- require'lspconfig'.rust_analyzer.setup{}
require('mappings')
require('nvim-cmp')
require"nrpattern".setup()
require('autolist').setup({})

-- Set up language servers
--
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'rust_analyzer', 'clangd', 'pyright'}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
      capabilities = capabilities
  }
end
