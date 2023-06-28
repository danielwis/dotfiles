local nls = require("null-ls")


local sources = {
  -- python
  nls.builtins.formatting.black,
  nls.builtins.formatting.isort,
  -- shell
  nls.builtins.formatting.shfmt,
  nls.builtins.diagnostics.shellcheck
}

nls.setup({ sources = sources })
