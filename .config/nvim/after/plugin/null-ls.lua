local nls = require("null-ls")


local sources = {
  -- python
  nls.builtins.formatting.black,
  nls.builtins.formatting.isort,
}

nls.setup({ sources = sources })
