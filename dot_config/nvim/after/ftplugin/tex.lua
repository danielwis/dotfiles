vim.opt.spelllang = 'en_gb'
vim.opt.spell = true

WC = function()
    local filename = vim.fn.expand('%')
    local res = vim.fn.system("detex " .. filename .. " | wc -w | tr -d '[:space:]'")
    print(res .. " words")
end
