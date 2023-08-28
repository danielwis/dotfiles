local nls = require("null-ls")


local sources = {
  -- python
  nls.builtins.formatting.black,
  nls.builtins.formatting.isort,
  -- shell
  nls.builtins.formatting.shfmt.with({
    extra_args = { "-i", "2", "-bn", "-ci" },
  }),
  nls.builtins.diagnostics.shellcheck,
  -- markdown, yaml, json etc.
  nls.builtins.formatting.prettierd,
  nls.builtins.diagnostics.jsonlint,
}

nls.setup({ sources = sources })
