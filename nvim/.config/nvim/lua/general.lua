vim.o.number = true
vim.o.virtualedit = 'onemore,block'
vim.o.whichwrap = 'h,l'
vim.o.fenc = 'utf-8'
vim.o.mouse = 'a'
vim.o.laststatus = 2
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.breakindent = true
vim.o.winblend = 10
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
-- vim.g.mapleader = '<Space>'

vim.api.nvim_set_option('clipboard', 'unnamedplus')
vim.g.clipboard = {
    name = 'wslClipboard',
    copy = {
        ['+'] = 'win32yank.exe -i',
        ['*'] = 'win32yank.exe -i',
    },
    paste = {
        ['+'] = 'win32yank.exe -o',
        ['*'] = 'win32yank.exe -o',
    },
}
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = {'*'},
    callback = function()
        vim.api.nvim_exec([[:%s/\s\+$//ge]], false)
    end,
})

