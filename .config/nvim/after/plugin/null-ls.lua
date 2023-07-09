local nls = require("null-ls")


local sources = {
  -- python
  nls.builtins.formatting.black,
  nls.builtins.formatting.isort,
  -- shell
  nls.builtins.formatting.shfmt,
  nls.builtins.diagnostics.shellcheck,
  -- markdown, yaml etc.
  nls.builtins.formatting.prettierd,
}

nls.setup({ sources = sources })
