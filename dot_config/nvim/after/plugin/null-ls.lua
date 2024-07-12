local nls = require("null-ls")


local sources = {
  -- shell
  nls.builtins.formatting.shfmt.with({
    extra_args = { "-i", "2", "-bn", "-ci" },
  }),
  nls.builtins.diagnostics.shellcheck,
}

nls.setup({ sources = sources })
