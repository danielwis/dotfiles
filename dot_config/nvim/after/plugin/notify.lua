local ntfy = require("notify")
ntfy.setup({
  background_colour = "#000000",
})
vim.notify = ntfy
